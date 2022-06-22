class Participant
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def busted?
    hand_total > TwentyOneGame::TOTAL_LIMIT
  end

  def hand_total
    total = cards.map(&:value).inject(:+) # calculates sum of faces of the cards

    # adjust hand total depending on how many aces
    if total > TwentyOneGame::TOTAL_LIMIT && ace?
      counter = 0
      # continue to adjust total until total is <= limit for as many aces as there are
      until counter == num_aces || total <= TwentyOneGame::TOTAL_LIMIT
        total -= 10 # substract 11 for default val, add 1 for adjusted val
        counter += 1
      end
    end
    total
  end

  def ace?
    cards.any?(&:ace?)
  end

  def num_aces
    cards.count(&:ace?)
  end

  def display_hand_total
    puts "#{self.class} total is #{hand_total}"
  end
end

class Player < Participant
  def hand_faces_and_suits
    cards.join(', ')
  end

  def hand_faces
    cards.map(&:face).join(', ')
  end

  def display_hand
    puts "PLAYER hand:\t#{hand_faces}"
  end
end

class Dealer < Participant
  def reached_minimum?
    hand_total >= TwentyOneGame::DEALER_MINIMUM
  end

  def hand_faces_and_suits
    ([cards.first] + (['unknown'] * (cards.length - 1))).join(', ')
  end

  def hand_faces
    ([cards.first.face] + (['unknown'] * (cards.length - 1))).join(', ')
  end

  def display_hand
    puts "DEALER hand:\t#{hand_faces}"
  end

  def reveal_hand
    puts self.class.to_s.upcase + " hand:\t" + cards.map(&:face).join(', ')
  end
end

class Deck
  attr_accessor :cards

  def initialize
    reset!
  end

  def reset!
    self.cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        cards << Card.new(face, suit)
      end
    end
  end

  def shuffle!
    cards.shuffle!
  end

  # make sure to shuffle deck first
  def deal(player, num_cards = 1)
    player.cards += cards.pop(num_cards)
  end
end

class Card
  SUITS = %w[H D S C].freeze
  FACES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(face, suit)
    @face = face
    @suit = suit
  end

  def to_s
    "#{face} of #{suit}"
  end

  def face
    case @face
    when 'J' then 'jack'
    when 'Q' then 'queen'
    when 'K' then 'king'
    when 'A' then 'ace'
    else          @face
    end
  end

  def suit
    case @suit
    when 'H' then 'hearts'
    when 'D' then 'diamonds'
    when 'S' then 'spades'
    when 'C' then 'clubs'
    end
  end

  def value
    case @face
    when 'J' then 10
    when 'Q' then 10
    when 'K' then 10
    when 'A' then 11
    else          @face.to_i
    end
  end

  def ace?
    @face == 'A'
  end
end

class TwentyOneGame
  attr_reader :deck, :dealer, :player
  NUM_INITIAL_CARDS = 2
  TOTAL_LIMIT = 21
  DEALER_MINIMUM = 17
  PAUSE_TIME = 2 # seconds

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!\n"
  end

  def display_goodbye_message
    puts "\nThanks for playing Twenty-One! Goodbye!"
  end

  def deal_initial_cards
    deck.deal(player, NUM_INITIAL_CARDS)
    deck.deal(dealer, NUM_INITIAL_CARDS)
  end

  def show_hands
    puts
    player.display_hand
    dealer.display_hand
  end

  def choose_move
    loop do
      puts
      puts 'Would you like to hit or stay? (h or s)'
      answer = gets.chomp.downcase
      return answer if %w[h s].include? answer

      puts 'Invalid answer, must input h or s.'
    end
  end

  def player_hit
    puts 'PLAYER chose to hit!'
    pause_and_clear_screen
    deck.deal(player)
  end

  def player_turn
    loop do
      show_hands
      move = choose_move
      if move == 'h' # HIT
        player_hit
        if player.busted?
          puts 'PLAYER has busted!'
          break
        end
      elsif move == 's' # STAY
        puts 'PLAYER chose to stay!'
        break
      end
    end
    pause_and_clear_screen
  end

  def dealer_turn
    num_cards_drawn = 0
    until dealer.busted? || dealer.reached_minimum?
      deck.deal(dealer)
      num_cards_drawn += 1
    end
    puts "DEALER has drawn #{num_cards_drawn} cards."
    pause_and_clear_screen
  end

  def show_result
    if player.busted?
      puts 'PLAYER has busted. DEALER wins!'
    elsif dealer.busted?
      puts 'DEALER has busted. PLAYER wins!'
    elsif player.hand_total > dealer.hand_total
      puts 'PLAYER has won'
    elsif player.hand_total < dealer.hand_total
      puts 'DEALER has won'
    else
      puts 'PLAYER and dealer have tied!'
    end
  end

  def reveal_all_hands
    puts
    puts '============= Final cards ============='
    player.display_hand
    dealer.reveal_hand
    puts '======================================='
  end

  def pause_and_clear_screen
    sleep(PAUSE_TIME)
    system 'clear'
  end

  def start
    display_welcome_message
    main_game
    display_goodbye_message
  end

  def main_game
    deck.shuffle!
    deal_initial_cards
    player_turn
    dealer_turn unless player.busted?
    show_result
    reveal_all_hands
  end
end

game = TwentyOneGame.new
game.start
