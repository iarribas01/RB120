=begin 
RPS Bonus features --- keeping score

Goal: implement keeping score functionality
  - play until someone reaches 10 points
  - should this be a class or a state? (explore both)

Notes
  * STATE
  - score instance var in Player
  - init to zero
  - increment by 1 every round
  - print final scores at end of every round
  - continue game one player reaches 10 points
    - if user decides to end game early, display
      winner with the higher score

  Using score as a state makes the most sense
  here because each player can have an individual
  score that increments throughout the game. This
  reflects the behaviors of a state. An object on
  the other hand, wouldn't be a great option because
  this would introduce an unnecessary level of complexity
  to the program and every time we want to get the score
  of, say, the human, we would probably have to say
  "human.score.score" which can be really redundant.


=end

class Move
  VALUES = ['rock', 'paper', 'scissors']

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

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
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
      puts "Please choose rock, paper, or scissors: "
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['One-One', 'Alexa', 'Siri'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
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
    puts "Welcome, #{human.name} to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!"
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
      puts "#{human.name} won Rock, Paper, Scissors with #{human.score} points!"
    elsif human.score < computer.score
      puts "#{computer.name} won Rock, Paper, Scissors with #{computer.score} points!"
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
  end
end

RPSGame.new.play

