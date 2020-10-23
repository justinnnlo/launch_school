class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end

  def self.hi  # Wrong because a class method can't call an instance method
    greet("Hello")
  end

  def self.hi
    greeting = Hello.new
    greeting.hi
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

p hello = Hello.new     # <Hello:[object_id_encoding]>
p hello.object_id       # Object id, which is NOT equal to its encoding
p hello.hi              # => nil, prints "Hello"

hello = Hello.new       # <Hello:[object_id_encoding]>
p hello.object_id       # Object id, which is NOT equal to its encoding
#p hello.bye            # NoMethodError

hello = Hello.new
#hello.greet            # ArgumentError: expecting 1 argument

hello = Hello.new
hello.greet("Goodbye")  # => nil, prints "Goodbye"

Hello.hi               # NoMethodError



class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

cat1 = AngryCat.new("Gundo", 5)
cat2 = AngryCat.new("Pimpinela", 10)



class Cat
  private
  attr_reader :type
  
  def initialize(type)
    @type = type
  end

  public
  def to_s
    "I'm a #{type} cat"
  end
end

p Cat.new("tabby").to_s



class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
#tv.manufacturer           # NoMethodError
tv.model                  # Runs model (empty)

Television.manufacturer   # Runs manufacturer (empty)
#Television.model          # NoMethod Error



class Cat
  attr_accessor :type

  def initialize(type)
    @type = type
    @age  = 0
  end

  def age
    @age
  end

  def age=(new)
    age = new
  end

  # def age+=(new)
  #   @age = @age + new
  # end

  def make_one_year_older
    @age += 1
  end
end

test = Cat.new("tabby")
p test.age
p test.make_one_year_older
p test.age



class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super high and a color of green"
  end

end


class MyClass
  attr_accessor :age
  def initialize(age)
    @age = age
  end

  def age+=(new)
    @age += new
  end
end

p test = MyClass.new(10)
p test.age                  # 10
p test.age = 20             # 20
p test.age += 10            # 30
p test.age                  # 30