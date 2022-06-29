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

  def value
    VALUES.fetch(rank, rank)
  end

  def compare_ranks(other)
    value <=> other.value
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

  def draw(num_cards = 1)
    reset if cards.empty?
    cards.pop(num_cards)
  end
end

class PokerHand
  def initialize(deck)
    @deck = deck
    @hand = deck.draw(5)
  end



  def print
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  attr_reader :hand, :deck

  def royal_flush?
    return false unless all_same_suit?
    return false unless ranks.difference(['Ace', 'King', 'Queen', 'Jack', 10]).empty?
    true
  end

  def straight_flush?
    return false unless all_same_suit?
    return false unless in_a_sequence?
    true
  end

  def four_of_a_kind?
    ranks.uniq.each do |rank|
      return true if count(rank) == 4
    end
    false
  end

  # 3 of a kind, one pair
  # needs to be further developed, solution
  # works but not in all scenarios
  def full_house?
    three_of_a_kind? && pair?
  end


  def flush?
    return false unless all_same_suit?
    return false if in_a_sequence?
    true
  end

  def straight?
    in_a_sequence? && !all_same_suit?
  end

  def three_of_a_kind?
    ranks.uniq.each do |rank|
      return true if count(rank) == 3
    end
    false
  end

  def two_pair?
    rank_quantities = ranks.uniq.map do |rank|
      count(rank)
    end
    return true if rank_quantities.count(2) == 2
    false
  end

  def pair?
    rank_quantities = ranks.uniq.map do |rank|
      count(rank)
    end
    return true if rank_quantities.count(2) == 1
    false
  end


  def all_same_suit?
    hand.map(&:suit).uniq.size == 1
  end

  def in_a_sequence?
    temp = values.sort
    last_val = temp.first
    # puts "#{temp} values ======== #{(temp.first)+1} upto #{temp.first + temp.length - 1}"
    temp.each do |current_val|
      return false if current_val != last_val - 1 && temp.first != current_val
      last_val = current_val
    end
    true
  end

  def ranks 
    hand.map(&:rank)
  end

  def values
    hand.map(&:value)
  end

  def count(rank)
    hand.count{|card| card.rank == rank}
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'