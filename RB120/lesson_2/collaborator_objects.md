Summray so far: classess group common behaviors and objects encapsulate their states in their instance variables

# Collaborator objects

Any object can be used to represent the state of an object.

**Objects that are stored as the state of another object are collaborator objects**. This is because they work with the class they're associated with.

Below, we set the object's instance variable `pet` to a custom object of class `Pet`
```ruby
class Person
  attr_accessor :name, :pet # pet is set

  def initialize(name)
    @name = name
  end
end

class Pet; end
class Bulldog < Pet
  def speak
    "Woof!"
  end
end

bob = Person.new("Robert")
bud = Bulldog.new           # assume Bulldog class from previous assignment

bob.pet = bud               # Set `bob`'s @pet instance variable to `bud`
bob                         #<Person:0x00007fbd7119b9b0 @name="Robert", @pet=#<Bulldog:0x00007fbd76017878>>
```

Here, the collaborator object is the `Bulldog` object binded to the variable `bud`.

By extension, when we call `bob.pet` it return `bud`, a `Bulldog` object. Thus, `bob.pet.speak` returns `"Woof!"` because we're essentially saying `bud.speak`.

We can essentially do the same with collections.

```ruby
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pets
  def jump
    "I jumped!"
  end
end

class Cat < Pets; end
class Bulldog < Pets; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty                  # [kitty]
bob.pets << bud                    # [kitty, bud]

bob.pets                           # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]
bob.pets.each { |pet| p pet.jump } # "I jumped!" is printed twice
```

The last line is necessary as `bob.pets` returns an array — so we need to iterate through the array.