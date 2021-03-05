# Exercise guide — RB120/RB129

## Class variables: inheritance and scope

```ruby
class MyClass
  @@name = "Jose"

  def name
    @@name
  end

  def age
    @@age
  end
end

class YourClass < MyClass
  @@age = 24
end

class HisClass < MyClass
  @@name = "Vahid"
  @@age = 21
end

test = MyClass.new
p test.name # Vahid given HisClass reassigns it
p test.age  # NameError since MyClass doesn't initialize the class variable

test = YourClass.new
p test.name # Vahid given HisClass reassigns it and inherited from MyClass
p test.age  # NameError since MyClass doesn't initialize the class variable

test = HisClass.new
p test.name # Vahid given HisClass reassigns
p test.age  # NameError since MyClass doesn't initialize the class variable
```

```ruby
class MyClass
  @@name = "Jose"
  @@age = 24
  @@message = "I'm a string!"

  def name
    @@name
  end

  def age
    @@age
  end
end

class YourClass < MyClass
  def message
    @@message
  end
end

class HisClass < MyClass
  @@name = "Vahid"
  @@age = 21
end

test = MyClass.new
p test.name # Vahid given HisClass reassigns it
p test.age  # 21 since HisClass reassigns it

test = YourClass.new
p test.name # Vahid given HisClass reassigns it and inherited from MyClass
p test.age  # 21 since HisClass reassigns it and inherited from MyClass
p test.message # "I'm a string" as it inheritas @@message from MyClass

test = HisClass.new
p test.name # Vahid given HisClass reassigns
p test.age  # 21 given HisClass reassigns
```

```ruby
class Computer
  def initialize
    @sound = "beep beep"
  end

  def self.about
    "Sometimes I go #{@sound}"
  end
end

p Computer.about # "Sometimes I go " because class methods can't access instance variables
```

## Constants: inheritance, scope, and namespacing

Namespacing (`::`) is used to distinguish files and information, such as constants, with the same names but saved in different locations. Thus, this avoids conflicting names.

```ruby
module MyModule
  TESTING = 100
  TESTING2 = 300
end

class MyClass
  TESTING = 200
end

p MyModule::TESTING   # 100
p MyModule::TESTING2  # 300

p MyClass::TESTING    # 200
p MyClass::TESTING2   # NameError: uninitialized constant MyClass::TESTING2 b/c not included
```

```ruby
module MyModule
  TESTING = 100
  TESTING2 = 300
end

class MyClass
  include MyModule
  TESTING = 200
end

p MyModule::TESTING   # 100 b/c the lookupchain starts in the current class
p MyModule::TESTING2  # 300

p MyClass::TESTING    # 200
p MyClass::TESTING2   # 300
```

```ruby
class HisClass
  TESTING = 100
  TESTING2 = 300
end

class MyClass < HisClass
  TESTING = 200
  TESTING2 = 400
end

p HisClass::TESTING   # 100 b/c the lookupchain starts in the current class
p HisClass::TESTING2  # 300

p MyClass::TESTING    # 200
p MyClass::TESTING2   # 300
```

Caveat: within their class or module, the constant is in its scope and doesn't require namespacing — in either instance or class methods
```ruby
class HisClass
  TESTING = 100
  TESTING2 = 300

  def testing
    TESTING
  end

  def self.testing
    TESTING
  end
end

HisClass.new.testing # 100
HisClass.testing     # 100
```

## Instance variables and methods: inheritance, scope, default values, and implicit self

```ruby
module MyModule
  def name
    "Hi, I'm #{@name}"
  end

  def class_variable
    @@test
  end
end

class MyClass
  include MyModule
  @@test = 10

  def initialize(name)
    @name = "namench"
  end
end

p test = MyClass.new("Jose")  # <MyClass:[object id encoding], @name = "namench">
p test.class_variable         # Error because there isn't a class variable defined in MyModule
p test.name                   # "Hi, I'm namench"
```

Unlike class and local variables, instance variables have a default value — `nil`
```ruby
class Xyz
  def pots
    @unassigned_instance_variable
  end

  def abc
    @@unassigned_class_variable
  end

  def cba
    unassigned_local_variable
  end
end

xyz = Xyz.new
p xyz.pots  # nil
p xyz.abc   # NameError
p xyz.cba   # NameError
```

Why can me call in `MyClass#cash_on_hand` `MyClass#cash` without specifying that it's an instance method (i.e., we're only saying `cash` rather than `self.cash`)?

Because within instance methods Ruby operates with an *implicit* self that is equivalent to the instance. Thus, an explicit self is not needed because Ruby can fall back on implicit self.
```ruby
class MyClass
  attr_accessor :name, :cash

  def initialize(name)
    @name = name
    @cash = 100
  end

  def cash_on_hand
    "I have $#{cash}"
  end
end

MyClass.new("Jose").cash_on_hand
```

## Class methods and the nature of `self`

We've seen above that in instance methods `self` refers to the instance — the object of said class.

However, within a class definition but outside an instance method `self` refers to the class being defined — not to an instance.

This explains why class methods are preceded by `self`, as in `self.[class_method]`.

### Class methods and singleton methods

Class methods belong to a type of methods called **singleton methods**. These are methods that only affect a single object.

In the case of class methods, the single object is the class itself. This is because a class is an object of class `class` that is instantiated through a class definition.

This implies that we can create class methods outside of the class definition **unless we define the class method before instantiating the class it refers to**.

This also implies **we can initialize and invoke a class variable in a class method outside of the class definition**. However, note that this will return a warning: `warning: class variable access from toplevel`. Best to avoid this fancy trick.

```ruby

class Gorilla
  def self.testy
    @@class
  end
end

def Gorilla.strength
  100
end

def Gorilla.classy
  @@class = 100
  @@class
end

Gorilla.strength # 100
Gorilla.classy   # 100
Gorilla.testy    # 100
```

## Methods in the general program execution

What happens if we invoke a method we define in the general program execution within a class definition?

```ruby
def blah
  "blah blah"
end

class Animal
  def woof
    "woof woof"
  end
end

class Dog < Animal
  def self.speak
    "I am #{blah}"
  end

  def test
    "Testing"
  end
end

p Dog.blah
p Dog.speak
p Dog.test


```

Explanation: `blah` is really `Object#blah`. Since `Dog` is a descendent of `Object`, it will inherit its instance method `blah` — and thus allows it to be executed in the instance method.

Note that instance methods can be called by their classes **if they don't 

## Modules and inheritance

```ruby
class HisClass
  @@test = 100
end

module MyModule
  def test
    @@test
  end
end

class MyClass < HisClass
  include MyModule
end

MyClass.ancestors  # Dog, MyModule...
MyModule.ancestors # [MyModule]
MyClass.new.test   # NameError: uninitialized class variable @@test in MyModule
```

Implication: be careful about calling variables from modules! If it isn't there, it won't be able to search up the lookupchain.

## Custom methods and string interpolation

```ruby
class Square
  def initialize
    @marker = :X
  end

  def to_s
    @marker
  end
end

puts "#{Square.new}"      # Returns the object and interpolates the literal object
puts "#{Square.new.to_s}" # Returns @marker and interpolates marker — wtf is interpolate anyways?

# Explanation: #{} does NOT call to_s — but the "" converts the object returned by #{} into a string
# Implication: if you want a custom object to be interpolated with #to_s, call it within #{}!
```

## Raising error for out-of-bounds indices `fetch` vs `[]`

```ruby
class FixedArray
  def initialize(ele)
    @array = Array.new(ele)
  end

  def []=(num, ele)
    @array[num] = ele
  end

  def [](num)
    @array.fetch(num)
  end
end

FixedArray.new(5)[7]  #IndexError
```

```ruby
class FixedArray
  def initialize(ele)
    @array = Array.new(ele)
  end

  def []=(num, ele)
    @array[num] = ele
  end

  def [](num)
    @array[num]
  end
end

FixedArray.new(5)[7]  #nil
```

## Object vs collaborator object method invokation

```ruby
class FixedArray
  def initialize(ele)
    @array = Array.new(ele)
  end

  def []=(num, ele)
    @array[num]
    @array[num] = ele
  end

  def [](num)
    @array.fetch(num)
  end
end

test = FixedArray.new(5)  # [nil, nil, nil, nil, nil]
test[3]                   # nil
test[-3]                  # nil
test[-6]                  # nil
test[7]                   # IndexError
test[7] = 3               # [nil, nil, nil, nil, nil, nil, 3]

# Additional insight: if you assign an array index greater than the size of the array, it creates new default objects until said assignment
```

```ruby
class FixedArray
  def initialize(ele)
    @array = Array.new(ele)
  end

  def []=(num, ele)
    self[num]
    @array[num] = ele
  end

  def [](num)
    @array.fetch(num)
  end
end

test = FixedArray.new(5)  # [nil, nil, nil, nil, nil]
test[3]                   # nil
test[-3]                  # nil
test[-6]                  # IndexError
test[7]                   # IndexError
test[7] = 3               # IndexError

# Insight: `Array#fetch` returns `IndexError` when out of bounds while `Array#[]` returns `nil`
```