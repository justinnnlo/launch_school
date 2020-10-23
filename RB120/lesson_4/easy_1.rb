true                    # TrueClass
"hello"                 # String
[1, 2, 3, "happy days"] # Array
142                     # Integer

# How to confirm: via the Kernel#class method



=begin
How can we confirm if a class has a specific method?
1. Identify where the method is
2. Run [Class].ancestors and verify whether it's there

Alternatively, we can also just call the method and confirm if it works.

We can add a module via `include [ModuleName]`
=end



# How is the name of the class printed?
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

small_car = Car.new
small_car.go_fast # prints "I am a Car and going super fast!"

# Solution: self.class implies that it takes the value of the calling method's class
# Further exploration: when does module look for a variable/method within the module vs the calling class?



# A new object is created with ClassName#new



# Which are the instance variables?

class Fruit
  def initialize(name)
    name = name   # No instance variable: it binds name to a local variable of the same name
  end
end

class Pizza
  def initialize(name)
    @name = name  # Binds name to an instance variable
  end
end


# What could we add to the class below to access the instance variable @volume?
# Solution: a getter method like `attr_reader :volume`
# Caveat: we don't strictly need a getter method — we could use Object#instance_variable_get("InstanceVariable")
class Cube
  def initialize(volume)
    @volume = volume
  end
end

big_cube = Cube.new(1000)
big_cube.instance_variable_get("@volume") # 1000



# Default return value of `to_s` when invoked on an object: it's object id as a string — excluding any instance variables

big_cube.to_s # "#<Cube:0x00007fd926947ad0>"
# This means: <ObjectClassName:object_id_encoding>



class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1 # self refers to the instance because it's within an instance method
  end
end



class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count # self means the class because outside an instance method self refers to the class
    @@cats_count
  end
end



class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# To create a new instance we need to call Bag#new and pass it 2 parameters for color and material
louis_vuitton = Bag.new("Brown", "Leather")