class Parent
  def say_hi
    p "Hi from Parent."
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  def send 
    p "send from Child..."
  end

  def instance_of?
    p "I am a fake instance"
  end
end

# puts Parent.superclass

c = Child.new 
puts c.instance_of? Child 
puts c.instance_of? Parent 