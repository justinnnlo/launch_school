puts "Hello".class
puts 5.class
puts [1, 2, 3].class


module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  attr_accessor :name

  include Walkable

  @@number_of_cats = 0
  COLOR = "Purple"

  def initialize(name)
    @name = name
    @@number_of_cats += 1
  end

  def personal_greeting
    puts "Hello! My name is #{name}!" # If @name hasn't been initialized yet, #{} evaluates to ""
  end

  def greet
    puts "Hello! My name is #{@name} and I'm a #{COLOR.downcase} cat!"
  end

  def rename(name)
    @name = name
  end

  def identify
    self
  end

  def to_s
    "I'm #{@name}!"
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def self.total
    puts @@number_of_cats
  end

end


# kitty = Cat.new("Sophie")
# kitty.personal_greeting
# kitty.name = "Luna"
# kitty.personal_greeting
# kitty.walk
# Cat.generic_greeting
# kitty.class.generic_greeting
# p kitty.name
# kitty.rename("Jose")
# p kitty.name
# p kitty.identify
kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
Cat.total
kitty.greet
puts kitty



class Person
  attr_writer :secret

  def share_secret
    puts self.secret
  end

  protected
  attr_reader :secret

  public
  def compare_secret(person2)
    @secret == person2.secret
  end
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret
person2 = Person.new
person2.secret = "Different!"
p person1.compare_secret(person2)