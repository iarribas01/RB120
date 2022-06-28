class Card
  include Comparable
  attr_reader :rank, :suit
  VALUES = {"Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14}.freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    rank_comparison = compare_ranks(other)
    if rank_comparison == 0
      compare_suits
    else
      rank_comparison
    end
  end

  def compare_ranks(other)
    VALUES.fetch(rank, rank) <=> VALUES.fetch(other.rank, other.rank) 
  end

  def compare_suits(other)
    suits = ['Diamonds', 'Clubs', 'Hearts', 'Spades']
    self_index = suits.find_index(suit)
    other_index = suits.find_index(other.suit)
    self_index <=> other_index
  end

  def numeric_card?
    rank.to_i.to_s == rank.to_s
  end

  def face_card?
    !!(rank.to_s =~ /[a-z]+/i)
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  attr_accessor :cards

  def initialize
    reset
  end

  def reset
    self.cards = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end
    cards.shuffle!
  end

  def draw
    reset if cards.empty?
    cards.pop
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2 # Almost always.
