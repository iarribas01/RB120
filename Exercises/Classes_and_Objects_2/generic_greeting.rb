=begin 
Covering questions:
  generic greeting (part 1)
  generic greeting (part 2)
=end

# class Cat
#   def self.generic_greeting # Cat.generic_greeting also works
#     puts "Hello! I'm a cat!"
#   end
# end

# kitty = Cat.new
# kitty.class.generic_greeting

#####################################

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Mrow! Imma cat"
  end

  def personal_greeting
    puts "Hello. My name is #{name}. What's your name?"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting