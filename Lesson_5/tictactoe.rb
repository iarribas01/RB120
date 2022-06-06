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
  INITIAL_MARKER = ' '

  def initialize
    # 3x3 grid of squares
    # data structure?
    @squares = {}
    (1..9).each {|key| @squares[key] = Square.new(INITIAL_MARKER)}
  end

  def get_square_at(key)
    @squares[key]
  end

end

class Square
  def initialize(marker)
    # state to keep track of p1, p2, or empty
    @marker = marker
  end

  def to_s
    @marker
  end

end

class Player
  def intialize
    # marker to keep track of player's symbol
  end

  def mark
  end

end

class TTTGame
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def play
    display_welcome_message
    loop do
      display_board

      break
      # first_player_moves
      # break if someone_won? || board_full?

      # second_player_moves
      # break if someone_won? || board_full?
    end
    # display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play