# States and behaviors

We tend to focus on two aspects when creating a class: states and behaviors.

- States track attributes for individual objects
  - Instance variables: scoped at the object level

 - Behaviors define what an object can do
  - Getter and setter methods, modules, instance and class methods

# Initializing an object

The `initialize` reserved word tells the class how to create a new object. **It is called every time an object is created.**

[Vocabulary: we call the `initialize` a **constructor method** because it gets triggered when we create a new object.]

Within it, we tell the class what instance variables —that is, variables at the scope of the object— are created and what values to bind them to.

# Instance variables

Instance variables are created within classes and have the scope of a single object.

They're easy to spot because they start with an `@` symbol.

More specifically, instance variables need to be created within the `initialize` method. In there, we need to bind each instance with its value — be it an argument to the method (through `new`) or not.

Instance variables exist only in objects. They continue to live after the `initialize` method is run, and only disappear when the object is deleted.

The values of instance variables are stored within an object. How the user  accesses and manipulates the variables depend on the class' getter and setter methods.

# Instance methods

Just as instance variables are variables *for a single instance*, instance methods are methods applied *to a single instance*.

Instance methods are defined like any other method.

    def bark
      puts "Woof, woof! This is my instance method."
    end

The difference is that they are created within a class.

Note that in contrast to the class styling, instance methods —like other methods— are typically written in `snake_case`.

## Accessor methods

Some of the most used instance mthods are accessor methods.

Accessor methods tell the class what permissions to give users in accessing and modifying instance variables. There are 2 types of accessor methods:
1. Getter methods, that "get" or return the value of an instance
2. Setter methods, that "set" or modify the value of an instance

These are defined like any other method. Let´s explore this by expanding the number of instance variables for `Cook`:
    
    class Cook
        def initialize(name, age, skill)
          @name = name
          @age = age
          @skill = skill
          @reputation = 0
        end
    end

    Marcela = Cook.new("Marcela", 54, 3)

In the example above, our `Cook` method is modified to accept 3 arguments and set a fourth instance variable to 0 to each object.

How can we retieve the value of reputation? By adding this outside of the `initialize` method:

    def reputation
      @reputation
    end

What's going on? We're creating a method called `reputation` that simply returns the value of the instance variable `reputation`. **This is an example of a getter mehtod.**

How could we change the value of reputation? It's setter method would typically look like below:

    def reputation=(reputation)
      @reputation = reputation
    end

**This setter method** says: create a method called `reputation=` that results in the instance variable `reputation` being reassigned to the argument being passed.

## Syntactic sugar for accessor methods

This topic is important because it means that accessor methods don't have to be typed out.

Instead of writing out a full method as above for each setter and getter method, we can take advantage of `accessor`. There are 3 types:
1. `attr_writer`: setter method
2. `attr_reader`: getter method
3. `attr_accessor`: both setter and getter methods

How do we create one? By writing the symbol equivalent of each instance variable.

    class Cook
        attr_reader :name
        attr_writer :age
        attr_accessor :skill, :reputation

        def initialize(name, age, skill)
          @name = name
          @age = age
          @skill = skill
          @reputation = 0
        end
    end

See the code above: we're making `name` read (getter) only, `age` write (setter) only, and `skill` and `reputation` with both setters and getters. 

# Exercises

1. Create a **class called MyCar**. When you initialize a new instance or object of the class, **allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well**. Create instance methods that allow the car to **speed up, brake, and shut the car off**.

In essence, this requires us to create 4 instance variables. 3 are bound to the arguments of the user and 1 is bound to 0. We also need to create 3 methods:

a. Speed up: increase the speed by the argument sent
b. Brake: decrease the speed by the argument sent
c. Shut off: set speed to 0

    class MyCar

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
    end

2. Add an accessor method to your MyCar class to **change and view the color of your car**. Then add an accessor method that allows you to view, but not modify, the year of your car.

    class MyCar

      attr_accessor :color
      attr_reader :year

      #Excludes rest of class for brevity
    end

3. You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.

    class MyCar

      attr_accessor :color
      attr_reader :year

      #Excludes rest of class for brevity

      def spray_paint(new_color)
        @color = new_color
        puts "Your new #{color} car is fantastic!"
      end
    end



# **Free recall**

# States and behaviors

Classes define 2 things: an object's state and its behavior.

The object's state refers to the data that's associated with the object — it's attributes.

An object's behaviors refer to how we can retrieve and modify the object's data — that is, it's accessor methods.


# Initializing a new object

An object is initialized when the `::new` class method is called.

But for an object to be passed an argument it needs to initialize them within the class so the object knows what to do with those arguments.

This is done within the `def initialize(p1..pN)` method definition within the class, where `p1..pN` are every parameter from 1 to N (note: it can also be 0).

Within the initialize method, the class has to bind a local variable to the argument.

Hence, below we are initializing the instance variable `p1` and binding it with the argument passed to the object `@p1`. But note that we don't need to pass an object, as `p2 = 10` demonstrates

```ruby
class MyMethod
  def initialize(p1)
    @p1 = p1          # p1 is a local variable, @p1 is an INSTANCE variable
    @p2 = 10
  end
  attr_accessor :p1, :p2
end
```

# Instance variables

`@p1` and `@p2` above are instance variables — variables that are accessible throughout the class definition for a specific instance of the class.

# Instance methods

Instance methods refer to methods that are available to specific instances rather than to the class itself.

# Accessor methods

```ruby
class MyMethod

  def initialize(a1, a2, a3) # Each parameter is an object passed to the object as its initialized
    a1 = @a1                 # @ refers to an instance variable
    a2 = @a2
    a3 = @a3
  end

  attr_accessor :a1, :a2, :a3 #
end
```