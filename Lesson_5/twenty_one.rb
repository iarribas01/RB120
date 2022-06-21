=begin
  Goal: get highest to 21 without going over

  Turn:
    Player
      hit: can hit as many times as they
           want without "busting"
      stay: ends their turn

    Dealer
      hit: can hit as many times as they
           want without "busting"
      stay: ends their turn but not allowed
            until hand is at least 17
  
  Player goes first, then dealer goes, game
  will halt as soon as someone busts. Final
  comparison made after both dealer and player
  have made their moves without busting.
  The one with the greatest score wins

  Noun: Hand, Card, Player, Dealer, deck, game, total
  Verb: Bust, hit, stay, deal

  Player
    busted?, hit, stay, total
  
  Dealer
    busted? hit, stay total deal
  
  Participant

  Deck 
    def (should this be here or in dealer)

  Card
  Game
    start
=end

class Participant
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def busted?
    hand_total > TwentyOneGame::TOTAL_LIMIT
  end

  def hand_total
    total = cards.map(&:value).inject(:+)

    # adjust hand total depending on how many aces
    if total > TwentyOneGame::TOTAL_LIMIT && has_ace?
      counter = 0
      # continue to adjust total until total is <= limit for as many aces as there are
      until counter == num_aces || total <= TwentyOneGame::TOTAL_LIMIT 
        total -= 10 # substract 11 for default val, add 1 for adjusted val
        counter += 1
      end
      total
    else
      total
    end
  end

  def has_ace?
    cards.any? {|c| c.face == 'ace'}
  end

  def num_aces
    cards.count {|c| c.face == 'ace'}
  end

  def display_hand_total
    puts "#{self.class} total is #{hand_total}"
  end

  def reveal_hand
    puts self.class.to_s + "\t" +cards.map(&:face).join(', ')
  end
end

class Player < Participant
  def hit(deck)
    deck.deal(self)
  end

  def hand
    cards.join(', ')
  end

  def hand_values
    cards.map(&:face).join(', ')
  end

  def display_hand
    puts "PLAYER hand:\t#{hand_values}"
  end
end


class Dealer < Participant
  def reached_minimum?
    hand_total >= TwentyOneGame::DEALER_MINIMUM
  end

  def hand
    ([cards.first] + (["unknown"] * (cards.length-1))).join(', ')
  end

  def hand_values
    ([cards.first.face] + (["unknown"] * (cards.length-1))).join(', ')
  end

  def display_hand
    puts "DEALER hand:\t#{hand_values}"
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
  SUITS = ['H', 'D', 'S', 'C']
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
           'J', 'Q', 'K', 'A' ]

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

  # HAVE TO DECIDE WHERE TO PLACE ACE VALUE
    # needs to know what cards player has

  def value
    case @face
    when 'J' then 10
    when 'Q' then 10
    when 'K' then 10
    when 'A' then 11
    else          @face.to_i
    end
  end


end

class TwentyOneGame
  attr_reader :deck, :dealer, :player
  NUM_INITIAL_CARDS = 2
  TOTAL_LIMIT = 21
  DEALER_MINIMUM = 17

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-One! Goodbye!"
  end

  def deal_initial_cards
    [player, dealer].each do |participant|
      deck.deal(participant, NUM_INITIAL_CARDS)
    end
  end

  def start
    display_welcome_message
    main_game
    display_goodbye_message
  end

  def show_hands
    player.display_hand
    dealer.display_hand
  end


  def choose_move
    loop do
      puts "Would you like to hit or stay? (h or s)"
      answer = gets.chomp.downcase
      return answer if %w(h s).include? answer
      puts "Invalid answer, must input h or s."
    end
  end

  def player_turn
    loop do
      show_hands
      move = choose_move
      if move == 'h' # HIT
        puts "Player chose to hit!"
        player.hit(deck)
        if player.busted?
          puts "Player has busted!"
          break
        end
      elsif move == 's' # STAY
        puts "Player chose to stay!"
        break
      end
    end
  end

  def dealer_turn
    # hit until hand value total is at least 17
    # computer run
    until dealer.busted? || dealer.reached_minimum? 
      deck.deal(dealer)
      puts "Dealer has drawn a card!"
    end
  end

  def show_result
    player_total = player.hand_total
    dealer_total = dealer.hand_total
    if player.busted?
      puts "Player has busted. Dealer wins!"
    elsif dealer.busted?
      puts "Dealer has busted. Player wins!"
    elsif player_total > dealer_total
      puts "Player has won "
    elsif player_total < dealer_total
      puts "Dealer has won"
    else
      puts "Player and dealer have tied!"
    end
  end

  def reveal_all_hands
    player.reveal_hand
    dealer.reveal_hand
  end

  def clear
    system 'clear'
  end

  def main_game
    deck.shuffle!
    deal_initial_cards
    player_turn
    dealer_turn
    show_result
    reveal_all_hands
  end
end

game = TwentyOneGame.new
game.start
