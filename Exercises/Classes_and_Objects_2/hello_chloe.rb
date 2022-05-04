class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(name)
    # puts "#{self.name} was renamed to #{name}!"
    self.name = name
  end
end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name