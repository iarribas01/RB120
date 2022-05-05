=begin 
Covering questions:
  identify yourself (part 1)
  identify yourself (part 2)
=end


# class Cat
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

#   def identify
#     self
#   end
# end

# kitty = Cat.new('Sophie')
# p kitty.identify

#######################

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty