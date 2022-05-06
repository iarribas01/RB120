=begin 
Covering questions:
  method lookup (part 1)
  method lookup (part 2)
  method lookup (part 3)
=end

# class Animal
#   attr_reader :color

#   def initialize(color)
#     @color = color
#   end
# end

# class Cat < Animal
# end

# class Bird < Animal
# end

# cat1 = Cat.new('Black')
# cat1.color

# Suspected lookup path

# Cat  
# Animal 



###################
# class Animal
# end

# class Cat < Animal
# end

# class Bird < Animal
# end

# cat1 = Cat.new
# cat1.color

# Cat  
# Animal 
# Object
# Kernel 
# BasicObject


##############

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

# Bird 
# Flyable 
# Animal