class MyCar
  # attr_accessor :color
  # attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c 
    @model = m
    @current_speed = 0

    puts "The #{y} #{c} #{m} has been initialized."
  end

  def speed_up(num)
    @current_speed += num
    puts "Speeding up!"
  end

  def brake(num)
    @current_speed -= num
    puts "Braking..."
  end

  def shut_off
    @current_speed = 0
    puts "Shutting down."
  end

  def current_speed
    @current_speed
  end

  def color=(c)
    @color = c
    puts "You have changed the color to #{@color}."
  end

  def color
    puts "The color of this car is #{@color}."
  end

  def year 
    puts "The year of this car is #{@year}."
  end

  def spray_paint(new_color)
    @color = new_color
    puts "The car has been spray painted #{@color}."
  end
end

my_precious = MyCar.new(2016, 'Black', 'Toyota')

my_precious.color
my_precious.spray_paint("Yellow")
my_precious.color
