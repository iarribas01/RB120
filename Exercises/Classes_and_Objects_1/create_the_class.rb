=begin 
Covering questions:
  create the class
  create the object
  what are you
  hello sophie (part 1)
  hello sophie (part 2)
  reader
  writer
  Accessor
=end


class Cat
  attr_accessor :name

  def initialize(name)
    # puts "I'm a cat!"
    @name = name
  end

  def greet
    puts "Hellooooo, my name is #{name} <3" # using getter method
    # puts "Hellooooo, my name is #{self.name} <3" # using getter method
    # puts "Hellooooo, my name is #{@name} <3" # directly accessing instance variable
  end

end

kitty = Cat.new("Oliver")
kitty.greet
kitty.name = "Luna"
kitty.greet