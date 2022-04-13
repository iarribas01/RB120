class MyCar
  attr_accessor :color, :current_speed
  attr_reader :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c 
    @model = m
    @current_speed = 0
  end

  def self.calc_gas_mileage(miles_traveled, gallons_used)
    miles_traveled / gallons_used.to_f
  end

  def to_s
    "#{year} #{color} #{model}. Currently going #{current_speed} mph."
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
    puts "The car has been spray painted #{color}."
  end
end

# my_precious = MyCar.new(2016, 'Black', 'Toyota')
# puts my_precious
# my_precious.color
# my_precious.spray_paint("Yellow")
# my_precious.color
# my_precious.brake(10)
# my_precious.shut_off


#===================


class Person
  attr_reader :name
  # attr_accessor :name
  def initialize(name)
    @name = name
  end

  # def name=(n)
  #   @name = n
  # end
end

bob = Person.new("Steve")
bob.name = "Bob"