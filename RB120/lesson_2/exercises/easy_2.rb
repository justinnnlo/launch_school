require "byebug"

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode

  # def initialize(name, address, city, state, zipcode)
  #   @name, @address, @city, @state, @zipcode = name, address, city, state, zipcode
  # end
end

class Employee
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode

  # def initialize(name, address, city, state, zipcode)
  #   @name, @address, @city, @state, @zipcode = name, address, city, state, zipcode
  # end
end

# betty = Customer.new("Jose", "Juan Acevedo 105", "Lima", "Lima", "28010")
# bob = Employee.new("Jose", "Juan Acevedo 105", "Lima", "Lima", "28010")
# betty.print_address
# bob.print_address



# module Drivable
#   def drive
#   end
# end

# class Car
#   include Drivable
# end

# bobs_car = Car.new
# bobs_car.drive



# class House
#   include Comparable  # Include Comparable to get methods like <=>
#   attr_reader :price

#   def initialize(price)
#     @price = price
#   end

#   def <=>(other)
#     price <=> other.price
#   end
# end

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < home2
# puts "Home 2 is more expensive" if home2 > home1



# class Transform
#   def initialize(string)
#     @string = string
#   end

#   def uppercase(string=@string)
#     string.upcase
#   end

#   def self.lowercase(string)
#     string.downcase
#   end
# end

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')




# class Something
#   def initialize
#     @data = 'Hello'
#   end

#   def dupdata
#     @data + @data
#   end

#   def self.dupdata
#     'ByeBye'
#   end
# end

# thing = Something.new
# puts Something.dupdata  #"ByeBye"
# puts thing.dupdata      #"HelloHello"



# class Wallet
#   include Comparable

#   def initialize(amount)
#     @amount = amount
#   end

#   def <=>(other_wallet)
#     amount <=> other_wallet.amount
#   end

#   protected
#   attr_reader :amount
# end

# bills_wallet = Wallet.new(500)
# pennys_wallet = Wallet.new(465)
# if bills_wallet > pennys_wallet
#   puts 'Bill has more money than Penny'
# elsif bills_wallet < pennys_wallet
#   puts 'Penny has more money than Bill'
# else
#   puts 'Bill and Penny have the same amount of money.'
# end



class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end
end

class Owner
  attr_accessor :number_of_pets
  attr_reader :name

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end
end

class Shelter
  attr_accessor :adoptions

  def initialize
    @adoptions = Hash.new { Array.new(0) }
  end

  def adopt(adopter, adoptee)
    @adoptions[adopter] += [adoptee]
    adopter.number_of_pets = adopter.number_of_pets + 1
  end

  def print_adoptions
    @adoptions.each do |adopter, adoptees|
      puts "#{adopter.name} has adopted the following pets:"
      adoptees.each { |pet| puts "a #{pet.type} named #{pet.name}"}
      puts ""
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

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
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."



class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    self.expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander




module Walk
  def walk
    "#{@name} #{gait} forward"
  end
end

class Person
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  include Walk

  def initialize(name, title)
    super(name)
    @title = title
  end

  def walk
    "#{@title} " + super
  end

  private
  
  def gait
    "struts"
  end
end

class Cat
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
p mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
p kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
p flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"