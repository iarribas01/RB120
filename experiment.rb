=begin
  Greetings!
  This is my laboratory. I perform all my experiments
  on classes and objects here:
  
  Last updated: 4/22/22
=end

##### basic object learning

# module Barkable ; end 
# module Swimmable ; end

# class Pet
#   attr_reader :age
#   HOUSE_NAME = "The Dirty Arribas House"
#   @@num_pets = 0

#   def initialize(name, age, fur_type)
#     @name = name
#     @age = age
#     @fur_type = fur_type
#     @@num_pets += 1
#   end

#   # getter
#   def name
#     @name
#   end

#   # setter
#   def name=(new_name)
#     @name = new_name
#   end

#   # getter
#   def fur_type
#     @fur_type
#   end

#   # class variable getter
#   def self.num_pets
#     @@num_pets
#   end
  
#   # instance method
#   def happy_birthday!
#     @age += 1 # using reassignment to access variable directly
#     # self.age += 1 # this is the use of a getter method
#     puts "Whooo! Happy birthday #{@name}! They just turned #{@age} years old!"
#   end

#   # instance method
#   def is_this_an_instance_method?
#     puts "Yes! This is an instance method."
#   end

#   # class method
#   def self.is_this_a_class_method?
#     puts "Yup! This is a class method."
#   end

#   # overriding the to_s method
#   def to_s
#     "This pet's name is #{@name} and they are #{age} years old."
#   end

#   # experimenting with protected accessibility
#   def compare_fur(other_pet)
#     puts "#{self.name} has #{self.fur_type} fur whereas #{other_pet.name} has #{other_pet.fur_type} fur."
#   end
  
#   def details 
#     "Name: #{self.name} | Class: #{self.class}"
#   end

#   protected :fur_type
# end

# class Dog < Pet
#   include Barkable
#   include Swimmable

#   # instance method
#   def beg
#     "#{name} used its puppydog eyes to beg!"
#   end

#   def bark_at(thing)
#     "#{@name} barked at #{thing.name}."
#   end
# end

# class GermanShep < Dog
#   def bark_at(thing1, thing2)
#     "#{@name} barked at #{thing1.name} and #{thing2.name}"
#   end
# end

# class Shibe < Dog
# end

# class Cat < Pet
#   # instance method
#   def scratch
#     puts "#{@name} used scratch!"
#   end

#   # override Pet's to_s method
#   def to_s
#     super + " Mmmmmrow!"
#   end
# end



# # gatsby = Cat.new("Gatsby", 10, "long and silky")
# # piper = GermanShep.new("Peeps", 5, "short and wirey")
# puts GermanShep.ancestors

# think:
# GermanShep
# Dog
# Swimmable
# Barkable
# Pet
# Object
# Kernel
# BasicObject


# mitzi = Shibe.new("Scrammy", 17, "medium and fluffy")

# puts piper.bark_at(mitzi, gatsby)
# puts piper.bark_at(mitzi)

# gatsby.compare_fur(piper)

# puts Pet::HOUSE_NAME # access a class constant

# gatsby.is_this_an_instance_method? # invoking an instance method
# Pet.is_this_a_class_method? # invoking a class method

# puts gatsby.details
# puts piper.details
# puts mitzi.details

# puts "#{gatsby.name} is #{gatsby.age} years old."
# gatsby.name = "Gatsbear" # syntactic sugar for gatsby.name=("Gatsbear")
# gatsby.happy_birthday!
# puts "#{gatsby.name} is #{gatsby.age} years old."
# gatsby.scratch

=begin
  Notes:

  Instance method vs class method
    - Instance method doesn't HAVE to use any instance variables,
      and class methods CAN use instance variables. However, class
      methods trying to access an instance variable will use the value
      nil for the variable, will not throw error
    - the only difference between the two types is an instance method
      is a class method definition is prepended with self and called
      by the class

  Accessibility
    - using the keywords private, protected, public at the bottom of
      class along with a symbol with the name of the data you want
      to change the accessibility of will change the accessibility
      of the getter method. The symbol's name MUST be the same
      name of the method you want to change the accessibility of
      ex)
        private :get_private_info --- will throw error if no method called "get_private_info"

  Class constant
    - accessed by two colons ClassName::CONSTANT_NAME
=end




# defining a method in a child class with
# a different number of parameters. Which
# method will be called?


# investigate super
# what happens when super is used inside a method
# what does it return
# what happens when super is used outside a method
# can you use the super keyword to call a diff
# method inside a method?


# what are the advantages/disadvantages of using
# setters/getters vs accessing directly
# what do the differences look like




########### constant definition

module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    puts Shape.ancestors
    SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

puts Square.sides # => 4
# Square.new.sides # => 4
# Square.new.describe_shape # => "I am a Square and have 4 sides."