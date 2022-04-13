module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal
end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable
end

piper = Dog.new
fishy = Fish.new
gatsby = Cat.new

puts piper.swim 
puts fishy.swim 
gatsby.swim


# class Animal
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

#   def speak
#     "Hello!"
#   end

# end
# # inside initialize method
#   # super -- without paren
#     # will automatically send the one arg over
#   # super() -- with paren
#     # specifies an initialize method with no args


# class GoodDog < Animal
#   attr_accessor :name
#   def initialize(color)
#     super()
#     @color = color
#   end

#   def speak
#     "#{super()} from GoodDog class!"
#   end
# end

# class BadDog < Animal
#   def initialize(age, name)
#     super(name)
#     @age = age
#   end
# end

# class Cat < Animal
# end


# piper = GoodDog.new("Piper")
# puts piper.speak
# # gatsby = Cat.new

# # puts piper.inspect
# # puts gatsby.speak

# # p BadDog.new(2, "bear")