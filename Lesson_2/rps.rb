=begin
1. Write description
Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.


2. Determine nouns and verbs
  - nouns: rule, player, move
  - verbs: compare, choose

3. Organize verbs with nouns
rule
player - move
move

compare

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
    if rock?
      return true if other_move.paper?
      return false
    elsif paper?
      return true if other_move.scissors?
      return false
    elsif scissors?
      return true if other_move.rock?
      return false
    end
  end

  def >(other_move)    
    if rock?
      return true if other_move.scissors?
      return false
    elsif paper?
      return true if other_move.rock?
      return false
    elsif scissors?
      return true if other_move.paper?
      return false
    end
  end

  def to_s
    @value
  end
end

class Player 
  attr_accessor :move, :name

  def initialize
    set_name
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
      break if  Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['One-One','Alexa','Siri'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end


class RPSGame
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

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."


    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
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
    answer == 'y'
  end

  def play
    loop do
      display_welcome_message
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end


RPSGame.new.play

=begin 
Ending questions (OOP walkthrough Design Choice 1)

1. is this design, with Human and Computer sub-classes, better? Why, or why not?

  This design is a lot better because this structure utilizes OOP to break down
  concepts into easy to understand chunks of information. This structure reflects
  a naturally hierarchical relationship between players and humans/computer.

  Some advantages now is that the program is easily flexible. Now, we can very
  easily make both players computers or both players human. It is also very easy
  to read the program (encapsulating allows us to build more layers of abstraction).



2. what is the primary improvement of this new design?

  Since the functionality of the program has not changed, the primary improvement
  of this design is readability, which is a very imporant component of writing code
  in large scale development projects.



3. what is the primary drawback of this new design?

  Perhaps creates a rigid separate between Humans and Computers when
  there are many similarities between the two for this game?

######################################################

Ending questions (OOP walkthrough Design Choice 2)
1. what is the primary improvement of this new design?
  This code is more flexible. It allows us to easily change the values
  of 'rock', 'paper', and 'scissors' if we wanted, and possibly add more.
  We've removed some hard coded parts of the program.


2. what is the primary drawback of this new design?
  The primary drawback is that it's actually less readable.
  Now, when we look at values called within the code, from the
  standpoint of someone who has never seen this code before, using
  Move::VALUES instead of just ['rock', 'paper', 'scissors'] looks
  confusing at a glance.

  minor drawbacks: method overriding comes at a cost because there
  may be other features you would rather compare with < > methods and
  other features you would rather see displayed than the to_s we implemented.
=end