class Vehicle
  attr_accessor :color, :current_speed, :year, :model

  def initialize(c, y, m)
    self.color = c
    self.current_speed = 0
    self.year = y
    self.model = m
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
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  attr_accessor :is_convertible

  def initialize(c, y, m, is_convertible)
    super(c, y, m)
    self.is_convertible = is_convertible
  end

  def self.calc_gas_mileage(miles_traveled, gallons_used)
    miles_traveled / gallons_used.to_f
  end

  def to_s
    "#{year} #{color} #{model}. Currently going #{current_speed} mph."
  end

end

family_car = MyCar.new("Green", "2003", "Van", false)