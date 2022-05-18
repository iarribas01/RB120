# make a class diagram

class Pet
  attr_reader :name
  private attr_reader :animal

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.length
  end
end

class Shelter
  attr_accessor :owners, :orphans
  def initialize
    @owners = {}
    @orphans = []
  end

  def add_pet(pet)
    orphans << pet
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
    @orphans.delete(pet)
  end

  def print_adoptions
    owners.each do |name, owner|
      puts "#{name} has adopted the following pets: "
      puts owner.pets
      puts
    end
  end

  def print_orphans
    puts "The Animal Shelter has the following unadopted pets: "
    puts orphans
    puts
  end

  def number_of_orphans
    orphans.length
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.add_pet(asta)
shelter.add_pet(laddie)
shelter.add_pet(fluffy)
shelter.add_pet(kat)
shelter.add_pet(ben)
shelter.add_pet(chatterbox)
shelter.add_pet(bluebell)
shelter.print_orphans
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal Shelter has #{shelter.number_of_orphans} unadopted pets."

=begin
Expected output:
  P Hanson has adopted the following pets:
  a cat named Butterscotch
  a cat named Pudding
  a bearded dragon named Darwin

  B Holmes has adopted the following pets:
  a dog named Molly
  a parakeet named Sweetie Pie
  a dog named Kennedy
  a fish named Chester

  P Hanson has 3 adopted pets.
  B Holmes has 4 adopted pets. 
=end