Encapsulation defines the boundaries of what is and is not allowed in your program by defining what functionality is available or unavailable. It's about only allowing minimum amount of information and behaviors needed for the user to accomplish his objective.

The underlying rationale of encapsulation is to reduce the likelihood of the program being used in unwanted ways. These include:
- Seeing information that should be private
- Manipulating objects that should not be

Ruby accomplishes these through classes, objects and their interfaces — methods.

Polymorphism: allowing objects of different data types to respond to the same interface. We've primarily seen how different data types can have the same method invocation.

Some ways to achieve polymorphism include:
- Duck typing
- Class inheritance
- Module mixin

```ruby
class Array
  def polymorphic
    "Same interface!"
  end
end

module MyModule
  def polymorphic
    "Same interface!"
  end
end

class MyClass
  include MyModule
end

class OtherClass < Array; end

Array.new.polymorphic
MyClass.new.polymorphic
OtherClass.new.polymorphic
```

Abstraction
- Think before answering, a lot of words at starts didn't target the question, almost backtracking a bit
- Objects allow you to use




Objects are the instances of classes. Every object thus has a class. An object is a construct that encapsulates i) attributes of a specific instance stored in their instance variables and ii) behaviours that define how the object can be interacted with.

```ruby
# All objects have a class
5.class                               # Integer
"Hi".class                            # String
class MyClass; end; MyClass.new.class # MyClass
```

Classes are objects that define the attributes and behaviours for objects of the type of that class. They're like the blueprint that defines the construct of the object and how it interacts.

They define the instance variables, which track the attributes of a specific instance of the class, and the methods, which govern the possible actions of an object. Classes also define to what extent part of an object's functionality is hidden through method access control.

```ruby

# Defining the attributes, behaviours, and method access control of MyClass class
class MyClass
  def initialize
    @value = 10
  end

  private
  def to_s
    @value.to_s
  end
end

MyClass.new.to_s # NoMethodError because we're protected MyClass#to_s

# All classes are objects of class class
5.class.class           # Class
MyClass.new.class.class # Class
```

Therefore, classes govern objects — but classes are also objects. This subtle point helps explain i) the popular reference that (almost) everything in Ruby is an object and ii) the flexibility of objects to program.



Class inheritance allows a class to take the attributes and behaviours of its subclass, unless explicitly overwritten.

```ruby
class Politician
  attr_reader :name, :state, :party
  def initialize(name, state, party)
    @name = name
    @state = state
    @party = party
  end

  def greet
    "Hi, I'm #{@name} and I'm looking for your vote!"
  end
end

# Defining a subclass with the attributes, methods and method control — but a more efficient initialize
class Democrat < Politician
  def initialize(name, state)
    super(name, state, "Democrat")
  end
end
```

This has several benefits:

- Mapping is-a relationships between classes, which helps us think more abstractly
- Reuse code written to make one class without having to rewrite it
- More easily maintain code as you only have to maintain it in one place



Ruby, unlike other programming languages, has single inheritance. This means that a class can only have — and can only inherit — from one superclass. This implies that the benefits of class inheritance seen above are limited to 1 sublass-superclass relationship. Additionally, sometimes we want to include behaviors that are shared by classes that do not have an is-a relationship.

For example, below we have an is-a relationship between `Animal` and its `Bird` subclass. However, we can't group and include methods only for their descendents that can dive underwater.

```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Bird < Animal
  def initialize(name, speed)
    @name = name
    @speed = speed
  end
end
```

Ruby solves this limiation through interface inheritance — that is, mixin in modules into classes. Modules are constructs that can hold other objects like classes and methods, and are used to insert their contents into other classes in an inheritance-like relationship. The clearest signal of this relationships is that when looking for the ancestors of a class the modules inserted in a class appear alongside the superclasses.

In the example below, we solve the problem first presented by creating the `Diveable` module and including it in `Bird` only. Thus, this solves the problem of fiving behaviors only through is-a relationships.

```ruby
module Diveable
  def dive
    "Diving underwater!"
  end
end

class Animal
  def initialize(name)
    @name = name
  end
end

class Bird < Animal
  include Diveable
  def initialize(name, speed)
    @name = name
    @speed = speed
  end
end

class Lizard < Animal
end
```



Classes and modules are distinct objects — a module is an object of class `module` while a class is an object of class `class` (which is the subclass of `module`).

The differenced between a class and a module stem from the fact that a class is a blueprint for the objects of that class whereas modules are more akin to containers that store code to be used within classes.

This has a series of downstream effects, like:
- Objects can be instantiated from a class, but not from a module
- A class can inherit from one superclass, but from any number of modules
- Class relationships describe an is-a relationship, whereas included modules do not