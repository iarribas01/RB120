class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

### 1
hello = Hello.new
hello.hi # hello

### 2
hello = Hello.new
hello.bye # NoMethodError

### 3 
hello = Hello.new
hello.greet #ArgumentError - wrong number of arg

### 4
hello = Hello.new
hello.greet("Goodbye") # Goodbye

### 5
Hello.hi # NoMethodError