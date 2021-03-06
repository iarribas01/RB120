require 'pry'

def joinor(list, delimeter=', ', word='or')
  joined_str = ''
  if list.length > 2
    joined_str << list[0, list.length-1].join(delimeter)
    joined_str << delimeter.chop
    joined_str << " #{word} "
    joined_str << list[-1].to_s
  elsif list.length == 2
    joined_str = "#{list[0]} #{word} #{list[1]}"
  elsif list.length == 1
    joined_str = list.first.to_s
  else
    joined_str = ''
  end
  joined_str
end

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def [](index)
    @squares[index]
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def center_unmarked?
    @squares[5].unmarked?
  end

  private

  def three_identical_markers?(squares)
    # binding.pry
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end


end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :score
  attr_accessor :name, :marker

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def increment_score
    @score += 1
  end
end


class TTTGame
  WINNING_SCORE = 5
  # @human_marker = "X"
  # @computer_marker = "O"

  attr_reader :board, :human, :computer, :current_marker
  attr_accessor :human_marker, :computer_marker

  def initialize
    @board = Board.new
    @human_marker = "X"
    @computer_marker = "O"
    @human = Player.new(human_marker)
    @computer = Player.new(computer_marker)
  end

  def play
    clear
    display_welcome_message
    choose_names
    choose_markers if choose_marker?
    choose_first_to_move
    main_game
    display_scores
    display_goodbye_message
  end

  def computer_moves_offense
    Board::WINNING_LINES.each do |line| # iterate through winning lines
      key ||= find_at_risk_square_key(line, computer.marker) # find at risk square
      return key if key
    end
    nil
  end

  def computer_moves_defense
    Board::WINNING_LINES.each do |line| # iterate through winning lines
      key ||= find_at_risk_square_key(line, human.marker) # find at risk square
      return key if key
    end
    nil
  end

  def computer_moves

    key ||= computer_moves_offense # search for offense move
    key ||= computer_moves_defense unless key # search for defense if no offense found
    key = 5 if board.center_unmarked? # default to center

    if key
      board[key].marker = computer.marker
    else
      board[board.unmarked_keys.sample].marker = computer.marker # choose a random one
    end
  end

  def find_at_risk_square_key(line, marker)
    squares_in_line = board.squares.values_at(*line)
    num_marker_in_line = squares_in_line.map(&:marker).count(marker)
    if num_marker_in_line == 2
      line.each do |key|
        return key if board[key].unmarked? #  select the cross section between two arrays
      end
    end
    nil
  end
  
  def display_board
    puts "#{human.name} is a #{human.marker}. #{computer.name} is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end
  
  def choose_marker?
    loop do 
      puts "Would you like to choose your marker? (y or n)"
      answer = gets.chomp.downcase
      if %w(y n).include? answer
        return answer == 'y'
      end
      puts "Invalid answer. Must put y or n.\n"
    end
  end

  def choose_markers
    choose_player_marker
    choose_computer_marker
  end

  def choose_computer_marker
    if human_marker == 'O'
      self.computer_marker = 'X'
      computer.marker = computer_marker
    end
  end

  def choose_player_marker
    answer = nil
    loop do 
      puts "Choose your marker:"
      answer = gets.chomp
      break if answer.size == 1
      puts "Invalid answer. Marker can only be one character long."
    end

    self.human_marker = answer
    human.marker = human_marker
  end
  private

  def generate_random_maker
    marker = nil
    loop do 
      marker = rand(33..110).chr # any random printable character
      break if marker.size == 1 # ensure double characters not returned
    end
    marker
  end

  def someone_won?
    computer.score == WINNING_SCORE || human.score == WINNING_SCORE
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      break if someone_won? || !play_again? 
      reset
      display_play_again_message
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def choose_first_to_move
    answer = nil
    loop do
      puts "Who do you want to go first?"
      puts "(A) #{human.name}. or (B) #{computer.name}?"
      puts "Or, let computer decide. (C)"
      puts ""
      answer = gets.chomp.downcase
      break if %w(a b c).include? answer
      puts "Invalid input. Must put either A, B, or C."
      puts ""
    end

    if answer == 'h'
      @current_marker = human.marker
    elsif answer == 'c'
      @current_marker = computer.marker
    elsif answer == 'x'
      @current_marker = [human.marker, computer.marker].sample
    end
  end

  def choose_names
    puts "Enter your name: "
    answer = gets.chomp

    if answer.empty?
      human.name = "human"
    else
      human.name = answer
    end

    if human.name == "human"
      computer.name = "computer"
    else
      computer.name = ["Siri", "Alexa", "One-one"].sample
    end
  end



  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == human_marker
  end


  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer_marker
    else
      computer_moves
      @current_marker = human_marker
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
      human.increment_score
    when computer.marker
      puts "Computer won!"
      computer.increment_score
    else
      puts "It's a tie!"
    end
    display_scores
  end

  def display_scores
    puts "#{human.name} has a score of #{human.score}."
    puts "#{computer.name} has a score of #{computer.score}."
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = @first_to_move
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end


game = TTTGame.new
# game.board.squares[1].marker = 'X'
# game.board.squares[2].marker = 'X'
# game.computer_moves
game.play
# game.display_board