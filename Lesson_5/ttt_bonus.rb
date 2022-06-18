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
  attr_reader :marker, :score
  attr_accessor :name

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
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer, :current_marker

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def play
    clear
    display_welcome_message
    obtain_names
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
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  private

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
      puts "(H) Human. or (C) Computer?"
      puts "Or, let computer decide. (X)"
      puts ""
      answer = gets.chomp.downcase
      break if %w(h c x).include? answer
      puts "Invalid input. Must put either H, C, or X."
      puts ""
    end

    if answer == 'h'
      @current_marker = HUMAN_MARKER
    elsif answer == 'c'
      @current_marker = COMPUTER_MARKER
    elsif answer == 'x'
      @current_marker = [HUMAN_MARKER, COMPUTER_MARKER].sample
    end
  end

  def obtain_names

  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
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
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
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
    puts "Human has a score of #{human.score}."
    puts "Computer has a score of #{computer.score}."
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