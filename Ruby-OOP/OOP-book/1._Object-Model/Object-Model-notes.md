# What is OOP?

Object-Oriented Programming is a programming approach built with large projects in mind. It focused on making code that is abstract and modular.

Some OOP principles and their consequences include:
- Abstraction
  - Only *show* necessary information is given to the user
- Modular
  - Code is reusable when possible
  - Programs are constructred from reusable code
- Encapsulation
  - Users can only *access* the minimum amount of information necessary to protect their data
    - Accomplished in Ruby by creating objects and providing them interfaces to retrieve data via methods
- Polymorphism ("many forms"): it allows us to use a common interface for many different type of objects — like using methods across different data types
- Inheritance: allow classes to inherit properties from parents, or provide an inheritance to their children, unless it is explicitly overwritten
  - Allows to more easily create object classes, and thus better accomplish the goals of encapsulation

## (Almost) everything is an object

Everything but a few things like blocks and methods are objects.

# Classes and how to define object behavior

Objects have classes assigned to them, which tell Ruby what values to assign and how to interact with the objects depending on their classes.

## Class inheritance

Inheritance (as per above) allows us to assign the properties of a parent class to its children class, unless the children explicitly overrides a specific property.

The parent class is called a *superclass*. If you go up enough times, every object starts off as a class *object*.

## Defining classes

Classes are defined similarly to methods:

    class GoodDog
    end

    Manuela = GoodDog.new
Creating a new object is called *instantiation* — ie, creating an instance of a class.

## Modules

Modules are blocks of code that can be reused across different classes. This is related to the objective of OOP to be modular and polymorpheus. 

### Creating modules

Modules are defined via the `module` keyword, similarly to methods and classes.
    
    module Bark
        def bark
            puts "Woof woof!"
        end
    end

### Syntax: modules vs methods

Why is the module the capitalized `Bark` but the instance method the downcase `bark`?

Because it belies two different sytactic conventions: methods are `snake_case` while classes and modules are `CamelCase`. 

### Including modules

Modules are included via the `include` reserved word within classes. Going back to `GoodDog`:

    class GoodDog
        include Bark
    end

    Manuela = GoodDog.new
    Manuela.bark
Guess what the last line prints? Look at `GoodDog#bark` for the answer!

### Method lookup

What methods can we apply to our `GoodDog` class?

There are 2 places to look that up:
1. The methods within the class of the object
2. The methods within the superclasses of the object

We can explore the superclasses of `GoodDog` with `Manuela.class.superclass`. We're calling the class of an object and on that result calling its superclass. As you can tell if you run the code, `GoodDog` has the `Object` superclass — because all classes implicitly receive superclass as their superclass.

So what's the superclass of object? If you run `GoodDog.class.superclass.superclass`, which is essentially `Object.superclass`, we get returned `BasicObject`. What's the superclass of `BasicObject`? You get back `nil`.

Another way to explore this is to use the `ancestors` class method. It returns both the modules appended to a method *and* the superclasses of the method.

# Section exercises

1. How do we create an object in Ruby? Give an example of the creation of an object.

An object is an instace of a class. An object can thus be created with whichever way we can create a class instance.

    my_empty_string = String.new
    my_non-empty_string = "Hello"
    array = [1,2,3]
    rand_integer = rand(0..10)
    pets = {type:["dog", "cat"], name: ["Mary", "Fillipa"]}
Note that not all objects are created the same way. Ruby's syntactic sugar allows us to create native data types with generous syntax. Yet custom classes that don't specify this have to resort to creating an object with the `.new` method.

2. What is a module? What is it's purpose? How do we use them with our classes? Create a module for a class.

A module is a block of code that can be used across different classes which typically contains methods.

The purpose of methods is to more easily insert and manage methods across classes.

Modules are added within classes via de `include <module_name>` syntax.

    module Help
        def help
            puts "Help me with this dish!"
        end
    end

    class KitchenDishes
        include Help
    end

    class Cook
        include Help
    end
For example, in the above block we've created two classes: `Cook` and `KitchenDishes`. We've also created the `Help` module and added it in both classes — so we can call the method on instances of both methods. 