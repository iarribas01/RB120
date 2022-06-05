=begin 
** adding onto previous bonus feature (keep history)
Goal: implement personalities/tendencies for certain computers

Notes:

  examples: R2D2 always chooses rock, Hal has a high tendency to choose scissors

  approach - 
    in computer class, with the various names
    individually program each tendency and wrap in
    a method called personify (like a choose method
    but it chooses moves based on the computer's 
    personality)
=end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(choice)
    @value = choice
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
    (paper? && (other_move.scissors? || other_move.lizard?)) ||
    (scissors? && (other_move.rock? || other_move.spock?)) ||
    (lizard? && (other_move.rock? || other_move.scissors?)) ||
    (spock? && (other_move.paper? || other_move.lizard?))
  end

  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
    (paper? && (other_move.rock? || other_move.spock?)) ||
    (scissors? && (other_move.paper? || other_move.lizard?)) ||
    (lizard? && (other_move.spock? || other_move.paper?)) ||
    (spock? && (other_move.scissors? || other_move.rock?))
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    @score = 0
    @history = []
  end

end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock: "
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    self.history << self.move
  end
end

class Computer < Player
  def set_name
    self.name = ['One-One', 'Alexa', 'Siri'].sample
  end

  def choose
    self.move = personify
    self.history << self.move
  end

  private
  def personify
    case name
    when 'One-One'
      Move.new('spock')
    when 'Alexa' # high chance of rock
      if rand(3) == 1
        Move.new('rock')
      else
        Move.new(Move::VALUES.sample)
      end
    else 
      Move.new(Move::VALUES.sample)
    end
  end
end

class RPSGame
  MAX_SCORE = 3
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome, #{human.name} to Rock, Paper, Scissors, Lizzard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_round_winner
    display_moves
    puts
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
  end

  def display_game_winner
    if human.score > computer.score
      puts "#{human.name} won Rock, Paper, Scissors, Lizard, Spock with #{human.score} points!"
    elsif human.score < computer.score
      puts "#{computer.name} won Rock, Paper, Scissors, Lizard, Spock with #{computer.score} points!"
    else
      puts "#{human.name} and #{computer.name} decided to end the game with a tie of #{human.name} points."
    end
  end

  def display_scores
    puts " ====== Current score ====== "
    puts "\t#{human.name}: #{human.score}"
    puts "\t#{computer.name}: #{computer.score}"
    puts " =========================== "
  end

  def display_history
    hum_name_formatted = human.name[0, 8].center(8)
    comp_name_formatted = computer.name[0, 5].center(8)
    
    # header row
    puts "\t\t#{hum_name_formatted}\t#{comp_name_formatted}"
    
    # rows
    for i in 0...human.history.length
      print "round #{i+1}:\t"
      puts "#{human.history[i]}\t\t#{computer.history[i]}"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    answer.downcase == 'y'
  end

  def reached_max_score?
    ( human.score >= MAX_SCORE || computer.score >= MAX_SCORE )
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      puts
      display_round_winner
      puts
      display_scores
      break unless !reached_max_score? && play_again?
    end
    display_game_winner
    display_goodbye_message
    display_history
  end
end

RPSGame.new.play