


###### 1 ######
# class Person 
#   attr_accessor :name 

#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert'
# bob.name                  # => 'Robert'





###### 2 ######

# class Person 
#   attr_reader :first_name 
#   attr_accessor :last_name

#   def initialize(name)
#     @first_name, @last_name = name.split(" ")
#     @last_name = '' if @last_name == nil
#   end

#   def name
#     (first_name + ' ' + last_name.to_s).strip
#   end
# end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'





###### 3 ######

# class Person 
#   attr_accessor :first_name, :last_name

#   def initialize(name)
#     parse_full_name(name)
#   end

#   def name
#     (first_name + ' ' + last_name.to_s).strip
#   end

#   def name=(new_name)
#     parse_full_name(new_name)
#   end

#   private

#   def parse_full_name(full_name)
#     parts = full_name.split
#     self.first_name = parts.first
#     self.last_name = parts.length > 1 ? parts.last : "" 
#   end
# end

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# bob.first_name            # => 'John'
# bob.last_name             # => 'Adams'



###### 4 ######

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# puts bob.name == rob.name



###### 5 ######
class Person 
  attr_accessor :first_name, :last_name

  def initialize(name)
    parse_full_name(name)
  end

  def name
    (first_name + ' ' + last_name.to_s).strip
  end

  def name=(new_name)
    parse_full_name(new_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.length > 1 ? parts.last : "" 
  end

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
