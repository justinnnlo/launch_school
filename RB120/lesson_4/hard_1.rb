class SecretFile

  def initialize(secret_data, logger)
    @data = secret_data
    @security_log = logger
  end

  def data
    @security_log.create_log_entry
    @data
  end
end

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end

test = SecretFile.new("Secret", SecurityLogger.new)
p test


# module WheeledVehicle
#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#     @tires = tire_array
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end

# class Vehicle
#   attr_accessor :speed, :heading

#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     @fuel_efficiency = km_traveled_per_liter
#     @fuel_capacity = liters_of_fuel_capacity
#   end

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end

# class Auto < Vehicle
#   include WheeledVehicle

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     # 4 tires are various tire pressures
#     super([30,30,32,32], 50, 25.0)
#   end
# end

# class Motorcycle < Vehicle
#   include WheeledVehicle

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     # 2 tires are various tire pressures
#     super([20,20], 80, 8.0)
#   end
# end

# class Catamaran < Vehicle
#   attr_reader :propeller_count, :hull_count

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#     @num_propellers = num_propellers
#     @num_hulls = num_hulls
#   end
# end

# auto = Auto.new([30,30,32,32], 50, 25.0)
# p auto
# moto = Motorcycle.new([30,30], 50, 25.0)
# p moto
# catamaran = Catamaran.new(5, 2, 40, 12)
# p catamaran


module Moveable

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  attr_accessor :speed, :heading
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    super(km_traveled_per_liter, liters_of_fuel_capacity)
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle; end

class Motorcycle < WheeledVehicle; end

class Seacraft
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading
  include Moveable

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(km_traveled_per_liter, liters_of_fuel_capacity)
    @num_propellers = num_propellers
    @num_hulls = num_hulls
  end
end

class Catamaran < Seacraft; end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

auto = Auto.new([30,30,32,32], 50, 25.0)
p auto
moto = Motorcycle.new([30,30], 50, 25.0)
p moto
catamaran = Catamaran.new(5, 2, 40, 12)
p catamaran



=begin
Problem: How to make Seacraft objects and their descendents have 10 more range than other Moveable objects?

Solution 1: implement code within Moveable — if an object's ancestors includes Seacraft, add 10 to the range

def range
  self.class.ancestors.include?(Seacraft) ? (@fuel_capacity * @fuel_efficiency) + 10 : @fuel_capacity * @fuel_efficiency
end

Preferred solution: implement within Seacraft class

def range
  super + 10
end

Whys is the latter better? Because it keeps code contained between what's necessary for each class — and no more!
=end
