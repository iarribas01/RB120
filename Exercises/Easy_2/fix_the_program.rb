=begin
Covering questions:

  Fix the program - Mailable
  Fix the program - Drivable
=end

# module Mailable
#   def print_address
#     puts "#{name}"
#     puts "#{address}"
#     puts "#{city}, #{state} #{zipcode}"
#   end
# end

# class Customer
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# class Employee
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# betty = Customer.new 
# bob = Employee.new
# betty.print_address
# bob.print_address





##############################


module Drivable
  def self.drive
  end

  # def drive
  # end
end

class Car
  include Drivable
end

bobs_car = Car.new
# bobs_car.drive

Drivable.drive