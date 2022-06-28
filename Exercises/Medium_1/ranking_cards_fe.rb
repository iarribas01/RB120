class Card
  include Comparable
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    rank_comparison = compare_ranks(other)
    if rank_comparison == 0
      compare_suits(other)
    else
      rank_comparison
    end
  end

  def compare_ranks(other)
    if numeric_card? && other.numeric_card?
      rank <=> other.rank
    elsif numeric_card? && other.face_card?
      -1
    elsif face_card? && other.numeric_card?
      1
    elsif face_card? && other.face_card?
      face_cards = ['Jack', 'Queen', 'King', 'Ace']
      self_index = face_cards.find_index(rank)
      other_index = face_cards.find_index(other.rank)

      self_index <=> other_index
    end
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

# cards = [Card.new(2, 'Hearts'),
#   Card.new(10, 'Diamonds'),
#   Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#   Card.new(4, 'Diamonds'),
#   Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#   Card.new('Jack', 'Diamonds'),
#   Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#   Card.new(8, 'Clubs'),
#   Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8

cards = [Card.new(4, 'Diamonds'),
  Card.new(4, 'Clubs'),
  Card.new(4, 'Spades'),
  Card.new(4, 'Hearts')]
puts cards.min.suit == 'Diamonds'
puts cards.max.suit == 'Spades'