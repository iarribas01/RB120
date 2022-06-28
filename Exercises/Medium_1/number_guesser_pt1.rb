=begin
Guessing game is a text-based game
where the user has a LIMIT of n guesses
per game and must guess numbers in range 1-100.

Nouns: limit, answer, remaining guesses, game
Verbs: guess

Game
  limit
  answer
  remaining guesses

  methods: 
    guess
    compare
    validate

=end

class GuessingGame
  RANGE = 1..100
  GUESSES_PER_GAME = 7

  def play
    reset
    main_game
    display_result
  end

  private

  def main_game
    puts
    loop do
      display_remaining_guesses
      get_user_guess
      display_guess_comparison
      break if correct?
      decrement_remaining_guesses
      break if no_more_guesses?
      puts
    end
  end

  def reset
    @remaining_guesses = GUESSES_PER_GAME
    @user_guess = nil
    generate_new_number
  end

  def generate_new_number
    self.number = rand(RANGE)
  end
  
  def decrement_remaining_guesses
    self.remaining_guesses -= 1
  end

  def no_more_guesses?
    remaining_guesses == 0
  end

  def display_result
    puts
    if correct?
      puts "You won!"
    elsif no_more_guesses?
      puts "You have no more guesses. You lost!"
    end
  end

  def display_guess_comparison
    case user_guess <=> number
    when 1 then puts "Your guess is too high."
    when -1 then puts "Your guess is too low."
    when 0 then puts "That's the number!"
    end
  end

  def correct?
    user_guess == number
  end

  def get_user_guess
    loop do
      print "Enter a number between #{RANGE.min} and #{RANGE.max}: "
      self.user_guess = gets.chomp.to_i
      break if valid_guess?
      print "Invalid guess. "
    end
  end

  def valid_guess?
    (1..100).include?(user_guess)
  end

  def display_remaining_guesses
    puts "You have #{remaining_guesses} guesses remaining."
  end

  attr_accessor :number, :user_guess, :remaining_guesses
end


game = GuessingGame.new

game.play
game.play

=begin
You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!
=end