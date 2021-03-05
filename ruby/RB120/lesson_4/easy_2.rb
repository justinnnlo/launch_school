class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new         # Returns an Oracle object <Oracle:[object_id]
p oracle.predict_the_future # "You will " + random sample from choices



class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new       # <RoadTrip:[object_id]>
p trip.predict_the_future # "You will " and a choice from RoadTrip choices

=begin

Why does RoadTrip#predict_the_future look for choices in RoadTrip rather than Oracle?

Because since the calling object is RoadTrip, it starts looking for the object in the current class. It then looks in the Oracle superclass.

=end


module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

=begin

What is the lookup chain for Orange and HotSauce?

Orange, Taste, Object, PP::ObjectMixin, Kernel, BasicObject
HotSauce, Taste, Object, PP::ObjectMixin, Kernel, BasicObject

=end


class BeesWax
  attr_accessor :type
  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

# Solution: remove the getter and setter methods and replace with attr_accessor
# Note: best practice is to refer to an instance variable through its getter method: `type` instead of `@type`


excited_dog = "excited dog"   # Local variable: not preceded by an @
@excited_dog = "excited dog"  # Instance variable: preceded by a @
@@excited_dog = "excited dog" # Class variable: preceded by a double @


class Television
  def self.manufacturer
    "Samsung"
  end

  def model
    # method logic
  end
end

p Television.manufacturer # Samsung

# self.manufacturer is the class method because it's preceded by `self`. Outside an instance variable self refers to the class
# Class methods are called via ClassName.class_method — e.g. Television.manufacturer



class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

cat1 = Cat.new("Yellow")
p Cat.cats_count  # 1
cat2 = Cat.new("Yellow")
p Cat.cats_count  # 2

=begin
@@cats_count is a class variable that counts the number of cats that have been initialized.

Each time an instance of the Cat class is initialized, @@cats_count increases by 1

We can test this by creating 2 instances of the Cat class and calling after each is initialized the number of cats
=end



class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# < Game added after Bingo to enable it to inherit Game#play



class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# If we were to add a Bingo#play method: it would execute that code instad of Game#play when Bingo#play is executed. This is because Ruby executes the first method in the lookup chain



=begin

What are the benefits of OOP?

- Code is modular
  - Less code needs to be written in large projects
    - Small projects: might be inefficient if the procedural solution is very straigthforward
  - Code is more easily maintained — there are less places to screw up
  - By extension of the 2 above, we can work faster
- Code is abstract
  - Working with objects can be more abstract than working with native data types because of their possible customization
  - Since we work with objects, we can approach problem-solving in a more abstract way
- Code is encapsulated
  - We have more control over the information we show to the user and allow them to manipulate
- Code is polymorpheous
  - By having a single interface for many data types (e.g. a method that works for many types), we make it easier for the user to use the methods
=end