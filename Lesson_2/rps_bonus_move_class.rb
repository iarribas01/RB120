=begin 
** adding onto previous bonus feature (lizard and spock)

Goal: add a class for each move
What would happen if we went even further and introduced 5 more 
classes, one for each move: Rock, Paper, Scissors, Lizard, and Spock. 
How would the code change? Can you make it work? After you're done,
 can you talk about whether this was a good design decision? 
 What are the pros/cons?


This makes the code a lot longer, but it is really good for namespacing.
Adding in 5 individual classes for each of the moves makes it easier to
search for a specific Move and view the characteristics of it. This should
also make it easier to debug logical errors since there is a clear separation
between all the different kinds of moves. The code, however, looks very redundant.
We have to keep calling the class method to figure out what type the objects are
rather than comparing strings. This is not much of an improvement.

=end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def to_s
    self.to_s
  end

  def <(other_move)
    weakness.any?(other_move.class) # possible refactored version
  end

  def >(other_move)
    strength.any?(other_move.class)
  end
end

class Rock < Move
  @@weakness = [Paper, Spock]
  @@strength = [Scissors, Lizard]
end

class Paper < Move
  @@weakness = [Scissors, Lizard]
  @@strength = [Rock, Spock]
end

class Scissors < Move
  @@weakness = [Rock, Spock]
  @@strength = [Paper, Lizard]
end

class Lizard < Move
  @@weakness = [Rock, Scissors]
  @@strength = [Spock, Paper]
end

class Spock < Move
  @@weakness = [Paper, Lizard]
  @@strength = [Scissors, Rock]
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
      puts "Please choose rock, paper, scissors, lizard, or spock: "
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
    puts "Welcome, #{human.name} to Rock, Paper, Scissors, Lizard, Spock!"
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
      puts "#{human.name} and #{computer.name} decided to end the game with a tie of #{human.score} points."
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
