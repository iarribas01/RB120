# module Activities
#   def greet
#     puts "Whaddup"
#   end
# end

# # 1.
# class Dude
#   include Activities

# end

# surfer_guy = Dude.new
# surfer_guy.greet

# 2.
# a module is a collection of behaviors
# purpose: share behaviors between different objects
  # of different superclasses

=begin   
NOTES ABOUT OOP
  - @ - instance var
  - @@ - class var
  - use @var_name to access instance variable directly
  - use var_name to access instance variable through getter method
  - use self.var_name = to invoke the var_name=() method
  - DO NOT use var_name = inside a method, will create a new local variable
  - self inside instance method -> ref instance object
  - self outside instance method -> ref class
=end

class GoodDog
  attr_accessor :name, :height, :weight, :age # read and write
  # attr_reader :name # read (getter method) only
  # attr_writer :name # write (setter method) only
  @@number_of_dogs = 0
  DOG_YEARS = 7

  def initialize(n, h, w, a)
    @name = n
    @height = h
    @weight = w
    @age = a * DOG_YEARS
    @@number_of_dogs += 1
  end

  def speak
    "#{name} says RO RO RO!"
  end
  
  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end


  def to_s
    "#{name} weighs #{weight} and is #{height} tall and #{age} years old."
  end
  # # getter
  # def name
  #   @name
  # end

  # # setter
  # def name=(name)
  #   @name = name
  # end

  def self.what_am_i
    "I'm a GoodDog class"
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def self.what_is_self
    self
  end
end

class Robot ; end

one_one = Robot.new
bb8 = Robot.new

puts one_one == bb8



# serj = GoodDog.new("Serj", '7 feet', '260lbs', 7)
# puts GoodDog.what_is_self
# puts serj.what_is_self

# serj.change_info("Piper", '1 cm', '1 g')
# puts serj.info
