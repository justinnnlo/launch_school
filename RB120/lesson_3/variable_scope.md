Key question: how does inheritance affect scoping?

# Instance variable scope

Instance varibales start with a `@` and track the state of an individual object. These don't across between objects.

- Instance variables are accessible within an instance method because an instance method is within the scope of an individual object
  - Includes if the instance variable has not been initialized or passed in the method
    - Example: using `attr*` to create the instance variable
    - Note: instance variables that have not been initialized return `nil`. Inversely, uninitialized local variables return `NameError`

    ```ruby
    class Person
      def get_name
        @name                     # the @name instance variable is not initialized anywhere
      end
    end

    bob = Person.new
    bob.get_name                  # => nil
    ```

Since the scope of instance variables is resticted to the individual object it's only accessible via the object's instance methods.

Note: instance variables initialized outside of an instance method are calles class instance variables — and avoid them for now.

```ruby
class MyClass
  attr_writer :name

  def initialize
    @value = 0
  end

  def value
    @value
  end

  def name
    @name
  end

  def age
    @age
  end
end

test = MyClass.new  # => #<MyClass:0x00007f8dd4bd2c48 @value=0> ===> Note @name isn't there
test.name           # nil
test.name = "Jose"  # "Jose"
test.name           # "Jose"
test                # => #<MyClass:0x00007f8dd4bd2c48 @name="Jose", @value=0>
test.surname        # NoMethodError: undefined method `surname' for #<MyClass:0x00007f8dd4bd2c48 @value=0, @name="Jose">
test.age            # => nil ===> uninitialized instance variable returns nil
test.age = 10       # NoMethodError: undefined method `age=' for #<MyClass:0x00007f8dd4bd2c48 @value=0, @name="Jose">
```

# Class variables scope

- Class variables start with `@@` and are scoped at the class level
- All objects of the class share the variable — which isn't possible with instance or local variables
- Class methods can access the class variable regardless of where it's been initialized

# Constant variable scope

Constants are written in all-caps. Their values are meant to not change.

Constant have a lexical scope.

Constants defined within classes can be accessed outside of it with `ClassName::CONSTANT`.

```ruby
class Person
  TITLES = %w(Mr Mrs Ms Dr)

  attr_reader :name

  def self.titles
    TITLES.join(", ")
  end

  def initialize(n)
    @name = "#{TITLES.sample} #{n}"
  end
end

TITLES = %w(Count Marquis Duke)

Person.titles  # => "Mr, Mrs, Ms, Dr"
Person::TITLES # => ["Mr", "Mrs", "Ms", "Dr"]
TITLES         # => ["Count", "Marquis", "Duke"]

bob = Person.new("bob")
bob.name       # 
```

# Inheritance and Variable Scope

## Instance variables

1. Instance variables can be initialized by the method of the superclass. The classic example is using the initialize of the superclass.
2. Mixin modules: if a module method initializes an instance variable and it's executed by an object, it initializes the object's instance variable

```ruby
module Swimable
  def can_swim
    @swim = true
  end
end

class Cat
  include Swimable
  attr_reader :swim
end

test = Cat.new
test.swim       # nil
test.can_swim   # true
test.swim       # true
```

Thus, once we initialize the instance variable — be it from the superclass or a module — we can use it within the object.

## Class variables

A superclass' class variable is available in its subclass. However, this is a double-edged sword because there's one copy of the variable across all sub-classes.

This is an example of how it can be dangerous:
```ruby
class Vehicles
  @@wheels = 4

  def wheels
    @@wheels
  end
end

class Bikes < Vehicles
  @@wheels = 2
end

class Cars < Vehicles; end

test = Vehicles.new
test.wheels     # 2

test2 = Bikes.new
test2.wheels    # 2

test3 = Cars.new
test3.wheels    # 2
```

This is why some Rubyists suggest not using class variables and opting instead for class instance variables, which we'll study later.

## Constants

Constants defined within a class are accessible only within the objects of said class. However, we can retrieve the constant by referencing the class the constant is in and calling the constant.

```ruby
class Dogs
  LEGS = 4
  TAIL = true
end

class Cats
  attr_reader :legs
  def initialize
    @legs = Dogs::LEGS
  end

  def tail
    TAIL
  end
end

test = Cats.new
test.legs # 4
test.tail # Error
```

`::` is the **namespace resolution operator**. This can be used for classes, modules or constants.

When a constant is defined in a superclass, it's accessible to the subclass with its name — as in the superclass.

```ruby
class Animal
  TAIL = true
end

class Dog < Animal
  def tail
    TAIL
  end
end

test = Dog.new
test.tail # true
```

However, when a module is involved we'll need to specify it.

```ruby
module Maintenance
  COST = 100

  def change_tires
    "Changing #{WHEELS} wheels"
  end
end

class Vehicles
  WHEELS = 4
end

class Car < Vehicles
  include Maintenance
  def maintenance_cost
    COST
  end
end

test = Car.new
test.change_tires # Error
test.maintenance_cost # 100
```

What happened?

Mistake: In `Car#change_tires` the method refers to `Maintenance#change_tires` to execute the code. While `Car::WHEELS` returns 4, the method is defined in `Maintenance`. Thus, it runs `Maintenance::WHEELS` which doesn't exist.

Correct: In `Car#maintenance_cost` the `Car` object calls `Car::COST`. Since `COST` is initialized and bount to `100` in `Maintenance`, which is mixedin `Car`, `Car::COST` points to the same object as `Maintenance::COST`.

As a corrollary to the 2nd point, we can change the constant in one class and affect several.

```ruby
module Maintenance
  COST = 100
end

class Vehicles
  include Maintenance
  def maintenance_cost=(new_cost)
    COST = new_cost
  end

  def maintenance_cost
    COST
  end
end

class Car < Vehicles
  include Maintenance
end

Maintenance::COST           # 100
Vehicles::COST              # 100
Car::COST                   # 100

test = Vehicles.new
test.maintenance_cost       # 100
test.maintenance_cost = 200
test.maintenance_cost       # 200

Maintenance::COST           # 200
Vehicles::COST              # 200
Car::COST                   # 200
```


