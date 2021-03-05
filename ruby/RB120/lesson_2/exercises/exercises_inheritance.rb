# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
# end

# class Car < Vehicle
# end

# truck1 = Truck.new(1994)
# puts truck1.year

# car1 = Car.new(2006)
# puts car1.year


# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   def initialize(year)
#     super
#     start_engine
#   end

#   def start_engine
#     puts 'Ready to go!'
#   end
# end

# truck1 = Truck.new(1994)
# puts truck1.year



# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   def initialize(year, bed_type)
#     super(year)
#     @bed_type = bed_type
#   end

#   attr_reader :bed_type
# end

# class Car < Vehicle
# end

# truck1 = Truck.new(1994, 'Short')
# puts truck1.year
# puts truck1.bed_type



# class Vehicle
#   def start_engine
#     'Ready to go!'
#   end
# end

# module Towable
#   def tow
#     puts "I can tow a trailer!"
#   end
# end

# class Truck < Vehicle
#   include Towable
#   def start_engine(speed)
#     super() + " Drive #{speed}, please!"
#   end
# end

# ==> # As Vehicle#start_engine doesn't take any parameters in Truck@start_engine we need to specify to super that no parameters will be sent — via `super()`

# truck1 = Truck.new
# puts truck1.start_engine('fast')
# truck1.tow



# module Towable
#   def tow
#     'I can tow a trailer!'
#   end
# end

# class Vehicle
#   def initialize(year)
#     @year = year
#   end

#   attr_reader :year
# end

# class Truck < Vehicle
#   include Towable
# end

# class Car < Vehicle
# end

# truck1 = Truck.new(1994)
# puts truck1.year
# puts truck1.tow

# car1 = Car.new(2006)
# puts car1.year



# class Animal
#   attr_reader :color

#   def initialize(color)
#     @color = color
#   end
# end

# class Cat < Animal
# end

# class Bird < Animal
# end

# p cat1 = Cat.new('Black')
# p cat1.color  # Cat, Animal => Animal has the method

# # Note: the lookup path continues until there aren't any ancestor classes or the method's been found
# p cat1.class.ancestors


class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color # Cat, Animal, Object, Kernel, BasicObject



module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color # Bird, Flyable, Animal => missed Flyable, Ruby checks the modules before the superclass



module Transportation
  class Vehicle; end
  class Truck < Vehicle; end
  class Car < Vehicle; end
end