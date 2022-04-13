module Mammal
  class Dog 
    def speak(sound)
      p "#{sound}"
    end 
  end

  class Cat 
    def say_name(name)
      p "#{name}"
    end
  end

  def self.some_random_method(num)
    num ** 2
  end
end

buddy = Mammal::Dog.new 
kitty = Mammal::Cat.new

buddy.speak("Arf!")
kitty.say_name('kitty')

puts Mammal.some_random_method(4)
puts Mammal::some_random_method(4)