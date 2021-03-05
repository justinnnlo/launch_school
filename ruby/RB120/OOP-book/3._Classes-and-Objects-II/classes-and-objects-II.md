# Class methods

Class methods are methods that are being called by the class rather than an instance.

Why would we need that?

It's useful for methods that are not about a specific instance. Remember that the key characteristics of instances are **state and behavior**. Thus, class methods are commonly used in the absence of these — particularly the abscence of attributes in a method. 

## Defining a class method

There's a small variation in defining class and instance methods.

    def self.shout
      puts "I'm a CLASS method!"
    end

Why?

Because within a class, self means *the class itself*.

    GoodDog.shout

## Class variables

Class variables have universal scope within the class. This contrasts with the instance variables, which have a **scope limited to a specific instance**.

What are the implications?
- Class variables use the `@@<variable_name>` syntax
- Class variables are defined outside the `initialize` method
- Class variables have the same value across all instances of a class
- When the class variable changes value, all current and future instances will have that value

So why would we use it?

To keep track of an attribute that affects all objects, such as the number of objects that have been initialized.

    class GoodDog

      @@number_of_dogs = 0

      def initialize
        @@number_of_dogs += 1
      end

      def self.number_of_dogs
        @@number_of_dogs
      end
    end

Did you see that subtlety? **With class variables we can't use `attr_accessor` because we're calling on the class** — not an instance. Thus, we need a class getter method.

# Constants

Constats are variables that are never meant to change. They're intiated when you write a variable that starts with a capital letter, though it's a best practice to fully capitalize them.

Constants *can change their values*, but it isn't a good practice. In larger programs and with shared teams, this can cause huge problems.

# to_s method

## `to_s` and `puts`

`puts` calls the `to_s` method on every object it prints except an array. On arrays, it prints each of its elements in a newline and applies `to_s` to those objects.

## `to_s` and string interpolation

`to_s` is also called automatically on string interpolation. That's what allows us to insert non-strings within a sentence, and still output a string.

## Implications

We can take advantage of this knowledge to change what is being print by an object.

Typically, the `puts` method prints the name of the class and location of the object as a string. Yet by defining a `to_s` method, we can have it printing whatever we want.

    class GoodDog
      def initialize(name)
        @name = name
      end

      def to_s
        "My name is #{@name}!"
      end
    end

Thus, the last line of this blocks prints "My name is Manuela!"

    Manuela = GoodDog.new("Manuela)
    #<GoodDog:0x00007fdb770bc480 @name="Manuela">
    puts Manuela
    => My name is Manuela!

Additionally, we can print the same result using string interpolation as it applies `to_s`.

    "#{Manuela}"
    => My name is Manuela!

## `p` vs `puts`

In contrast to the `puts` method that calls `to_s`,  `p` calls `inspect`.

As inspect is useful for debugging purposes, it's best not to override the method like we did with `to_s`. 

# Self

Self means different things according to the scop it's at.

1. Inside the class, but outside any method: it refers to **the class itself**
    - This is why we define class methods as `def self.<method_name>` — because in the first line (and thus outside the method) self means the class
    - `def self.<method_name>` is equivalent to `def <ClassName>.<method_name>`
2. Inside a method within the class: it refers to the class instance

Regarding #2, this is why we can set new values for instance variables like this:

    def instance_variable=(new)
      self.instance_variable = new
    end

Therefore: when using `self` be very conscious of the scope you're in.

# Exercises

1. Add a class method to your MyCar class that calculates the gas mileage of any car.

    class MyCar
      
      #Rest of code is excluded for brevity

      def MyCar.gas_mileage(miles, gallons)
        puts "#{miles}/#{gallons}"
      end
    end

2. Override the to_s method to create a user friendly print out of your object.

    class MyCar
      
      #Rest of code is excluded for brevity

      def to_s
        "This is a #{year} #{color} #{model} — couldn't be better!"
      end
    end

3. What's causing the error?

    class Person
      attr_reader :name
      def initialize(name)
        @name = name
      end
    end

    bob = Person.new("Steve")
    bob.name = "Bob"

In the last line we're trying to set the instance variable name for the object `bob` of class `Person` to a new value. However, the problem is that the variable only has a getter method. To solve it, it'd have to modify `attr_reader :name` to `attr_attributes :name` to also give it a setter method.

## Appendix: full MyCar class
    class MyCar
      
      attr_accessor :color
      attr_reader :year

      def initialize(year, color, model)
        @year = year
        @color = color
        @model = model
        @speed = 0
      end

      def speed_up(increase)
        @speed += increase
      end

      def brake(decrease)
        @speed -= decrease
      end

      def shut_off
        @speed = 0
      end

      def spray_paint(new_color)
        @color = new_color
        puts "Your new #{color} car is fantastic!"
      end

      def MyCar.gas_mileage(miles, gallons)
        puts "#{miles}/#{gallons}"
      end

      def to_s
        "This is a #{year} #{color} #{model} — couldn't be better!"
      end
    end
