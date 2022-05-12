class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase!
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # Fluffy
puts fluffy # *@name changed to 'FLUFFY'* , My name is FLUFFY
puts fluffy.name # FLUFFY
puts name # 'Fluffy'

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name # 42
puts fluffy # My name is 42
puts fluffy.name # 42
puts name # 43

=begin 
  The reason why the second example produces the result that it does is
  because the local variable name is passed into the Pet::new method as
  an argument. The value of this variable is an integer. The instance 
  variable @name is being initialized to the value that is passed in,
  in this case, the integer value 42, but is being changed to an entirely
  new value---a string, the return value of the to_s method invocation. This
  causes the @name to reference an entirely different variable that local
  variable name is reference within the main program.

  Now, the first example produces its result mainly due to the implementation
  of the to_s method for string objects. The to_s method called on a string
  object simply returns a reference to the calling object.

  Another reason is because within the constructor of Pet, the to_s
  method for the variable passed in will be the to_s method of the class
  that name belongs to. For example, the to_s method for integers is
  invoked from the Integer class rather than the Pet class.
=end

# check and see if to_s returns the calling object if called on a string

a = 'aiuhiugt8768'
puts a.object_id
a = a.to_s
puts a.object_id