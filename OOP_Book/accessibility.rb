# class GoodDog 
#   DOG_YEARS = 7
#   attr_accessor :name, :age 

#   def initialize(n, a)
#     self.name = n 
#     self.age = a 
#   end

#   def public_disclosure
#     "#{self.name} in human years is #{human_years}."
#   end

#   private 

#   def human_years
#     age * DOG_YEARS
#   end
# end

# sparky = GoodDog.new("Sparky", 4)
# p sparky.public_disclosure

class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected 

  def a_protected_method
    "Yes, I'm protected!"
  end
end

fido = Animal.new 
puts fido.a_public_method
puts fido.a_protected_method

=begin
public
  - can be called outside the class

protected
  - can be called anywhere inside class
    - act like public
  - can't be called outside class
    - act like private

private
  - can only be called within the class

=end