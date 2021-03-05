require "byebug"

# Code the class definition based on its behavior

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'

class Person
  attr_accessor :last_name, :first_name

  def initialize(name)
    parse_full_name(name)
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end

  def parse_full_name(full_name)
    (full_name.split.length == 2) ? (@first_name, @last_name = full_name.split) : (@first_name, @last_name = full_name, "")
  end

  def name=(name)
    parse_full_name(name)
  end

  def to_s
    name
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

p bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}" # It prints the **object** bob unless the to_s instance method overrides it