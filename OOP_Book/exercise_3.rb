module Towable
  def tow(obj)
    "I'm towing this #{obj}!"
  end
end
class Vehicle
  attr_accessor :color, :current_speed, :year, :model
  @@num_objects = 0

  def initialize(c, y, m)
    self.color = c
    self.current_speed = 0
    self.year = y
    self.model = m
    @@num_objects += 1
  end

  def self.num_objects
    @@num_objects
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def speed_up(num)
    self.current_speed += num
    puts "Speeding up!"
  end

  def brake(num)
    self.current_speed -= num
    puts "Braking..."
  end

  def shut_off
    self.current_speed = 0
    puts "Shutting down."
  end
  
  def spray_paint(new_color)
    self.color = new_color
    puts "This has been spray painted #{self.color}."
  end

  def to_s
      "#{year} #{color} #{model}. Currently going #{current_speed} mph."
  end

  def age
    puts "This vehicle is #{calc_age} years old."
  end

  private

  def calc_age
    Time.now.year - self.year.to_i
  end

end  

  

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
  include Towable
end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

family_car = MyCar.new("Green", "2003", "Van")
dads_truck = MyTruck.new("White", "2015", "truck")
# sleep(5)
family_car.age

# puts family_car
# puts dads_truck

# puts " ==== Car's lookup path ===="
# puts MyCar.ancestors
# puts " ==== Truck's lookup path ===="
# puts MyTruck.ancestors
# puts " ==== Vehicle's lookup path ===="
# puts Vehicle.ancestors
# puts " ==== Towable's lookup path ===="
# puts Towable.ancestors