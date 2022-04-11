module Activities
  def greet
    puts "Whaddup"
  end
end

# 1.
class Dude
  include Activities

end

surfer_guy = Dude.new
surfer_guy.greet

# 2.
# a module is a collection of behaviors
# purpose: share behaviors between different objects
  # of different superclasses

