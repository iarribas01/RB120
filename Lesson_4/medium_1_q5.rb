class KrispyKreme
  def initialize(filling_type, glazing)
    if filling_type == nil
      @filling_type = "Plain"
    else
      @filling_type = filling_type
    end
    @glazing = glazing
  end

  def to_s
    glazing == nil ? filling_type : "#{filling_type} with #{glazing}"
  end

  private
  attr_reader :filling_type, :glazing
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1 # "Plain"
puts donut2 # "Vanilla"
puts donut3 # "Plain with sugar"
puts donut4 # "Plain with chocolate sprinkles"
puts donut5 # "Custard with icing"