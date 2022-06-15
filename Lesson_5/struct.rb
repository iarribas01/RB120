# exploring what structs are

=begin 
  Def: convenient way to bundle a
  number of attributes together using
  accessor methods without
  having to write an explicit class.
=end


Customer = Struct.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end

# how to instantiate an object that was
# created from a struct
dave = Customer.new("Dave", "123 Main")
puts dave.name
puts dave.address
puts dave.greeting
puts ""

# no problems with wrong number of parameters
# instance variables automatically set to nil
mary = Customer.new("Mary")
puts mary.name
puts mary.address.inspect # nil
puts mary.greeting
puts ""

# Customer, Struct, Enumerable, Object, Kernel, BasicObject
p Customer.ancestors
