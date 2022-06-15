# Problem by Natalie Thompson

module Greetable
  def to_s
    "My name is #{@name} and I am a #{@job}"
  end
end

class Person
  include Greetable

  def initialize(name, job)
      @name = name
      @job = job
  end
  
  # def to_s
  #   "My name is #{@name} and I am a #{@job}"
  # end
end

roger = Person.new("Roger", "Carpenter")
puts roger

# Add 1 line of code for the person class
# and 1 line of code in the initalize method. 


#Other than that don't change Person.

# Output:
# "My name is Roger and I am a Carpenter"

#####################################


# Problem received from Raul Romero
class Human 
  attr_reader :name
  @@default_name = "Dylan"

  def initialize(name = @@default_name)
    @name = name
  end

  def hair_colour(color)
    "Hi, my name is #{name} and I have #{color} hair."
  end

  def self.hair_colour(color="blonde")
    color = "blonde" if color.empty?
    "Hi, my name is #{@@default_name} and I have #{color} hair."
  end
end

puts Human.new.hair_colour("blonde")  
# Should output "Hi, my name is Jo and I have blonde hair."

puts Human.hair_colour("")              
# Should "Hi, my name is Dylan and I have blonde hair."

#############

class Human  # Problem received from Raul Romero
  attr_reader :name 
  
  def initialize(name)
    @name = name
  end

  def equal?(other)
    name == other.name
  end

  def +(other)
    name + other.name
  end
end

gilles = Human.new("gilles") 
anna = Human.new("gilles") 

puts anna.equal?(gilles) #should output true # 
puts anna + gilles # should output annagilles 


##################

# #describe what the code below outputs and why from Joseph Ochoa

# module Attackable
#   def attack
#     "attacks!"
#   end
# end

# class Characters
#   attr_accessor :name, :characters 
  
#   def initialize(name) 
#     self.name 
#     @characters = [] 
#   end
  
#   def display
#     name
#   end
  
#   protected 
#   attr_reader :name
#   attr_writer :name
# end

# class Monster < Characters
#   include Attackable
  
#   def initialize(name)
#     super
#   end
# end

# class Barbarian < Characters
#   def ==(other)
#     if(super.self == super.self) # 
#       super.self == super.self
#     end
#   end
# end

# conan = Barbarian.new('barb') # @characters = [], @name = nil
# rob = Monster.new('monst') # @characters = [], @name = nil
# conan.characters << rob # conan = @characters = [rob], @name = nil
# p conan.display # nil

# p conan == rob
# p rob == conan
class Thing
  def something
    p "Something"
  end
end

class Being < Thing
  def initialize(name)
    @name = name
  end
  
  # def something
  #   p "Something"
  # end
end

class Human < Being
  def initialize(name)
    super
  end

  def something
    super
    super#.self
  end
end

human = Human.new('Isabel')
human.something



##################

##################

class BenjaminButton 
  attr_accessor :actual_age, :appearance_age
  # attr_writer :actual_age,

  def initialize
    @actual_age = 0
    @appearance_age = 100
  end
  
  def get_older
    self.actual_age += 1
    self.appearance_age -= 1
  end
  
  def look_younger
    self.appearance_age -= 1
  end
  
  def die
    self.actual_age = 100
    self.appearance_age = 0
  end
end

class BenjaminButton
end


benjamin = BenjaminButton.new
p benjamin.actual_age # => 0
p benjamin.appearance_age # => 100

benjamin.actual_age = 1
p benjamin.actual_age

benjamin.get_older
p benjamin.actual_age # => 2
p benjamin.appearance_age # => 99

benjamin.die
p benjamin.actual_age # => 100
p benjamin.appearance_age # => 0

########

class Person
  attr_reader :name
  attr_accessor :whatever, :something

  def initialize
    # @name = nil
  end

  def set_name
    @name = 'Bob'
  end 

  def a_method
    @random_variable
  end
end

bob = Person.new
# p bob.name
p bob

# p bob
# p bob.name
# p bob.whatever
# p bob.something

# p bob.a_method
