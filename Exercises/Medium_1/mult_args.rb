def my_method(string, *args)
  p args # array containing hash
  p *args # hash
  p format(string, *args)
end

# my_method(1, 2, 3)
# my_method("hello")
# my_method({hey: "hello"})
# my_method()
my_method("Interpolated string %<side>d, %<length>d", side: 10, length: 2)