class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def swim
    'swimming!'
  end
end

# Note: speak isn't in Animal because there isn't a good default across all animals

class Cat < Animal
  def speak
    "meow!"
  end
end

class Dog < Animal
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

susan = Bulldog.new
puts susan.speak
puts susan.swim

=begin
What's the method lookup path?

It's the order in which an object searches for the method to execute. It does so in adcending order — from the closest classes and module upwards to its ancestors.

We can find the exact heirarchy via `ClassName.ancestors`.
=end