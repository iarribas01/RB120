require 'pry'

=begin 

Write a description of the 
problem and extract major nouns and verbs

  Tic Tac Toe is a 2-player board game played
  on a 3x3 grid. Players take turns marking a
  square. The first player to mark 3 squares in
  a row wins

  nouns: player, board/grid, square
  verbs: win, mark, play


Organize the nouns and verbs

  Board
  Square
  Player
    - mark
    - play


Make an initial guess at organizing the verbs
into nouns and do a spike to explore the 
problem with temporary code


Optional - model into CRC cards

=end


class Board
  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  def initialize
    @squares = {}
    (1..9).each {|key| @squares[key] = Square.new}
  end

  def get_square_at(key)
    @squares[key]
  end

  def []=(key, marker)
    @squares[key].marker =  marker
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked?}
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker(HUMAN_MARKER) || !!winning_marker(COMPUTER_MARKER)
  end

  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  def winning_marker(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
      
      # if count_human_marker(@squares.values_at(*line)) == 3
      #   return TTTGame::HUMAN_MARKER
      # elsif count_computer_marker(@squares.values_at(*line)) == 3
      #   return TTTGame::COMPUTER_MARKER
      # end
    end
    nil
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end

  def draw
    puts "     |     |"
    puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
    puts "     |     |"
    puts ""
  end
end

class Square
  INITIAL_MARKER = ' '
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
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def clear
    system 'clear'
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice. "
    end
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result
    clear_screen_and_display_board
    
    if board.winning_marker(HUMAN_MARKER)
      puts "You won!"
    elsif board.winning_marker(COMPUTER_MARKER)
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %(y n).include? answer
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end


  def play
    display_welcome_message
    
    loop do
      display_board
      loop do
        human_moves
        break if board.someone_won? || board.full?
        
        computer_moves
        break if board.someone_won? || board.full?

        clear_screen_and_display_board
      end
      display_result
      break unless play_again?

      reset
      display_play_again_message
    end
    
    display_goodbye_message
  end
end

game = TTTGame.new
game.play