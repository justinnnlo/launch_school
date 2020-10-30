module MyModule
  TEST = 100
  @@test = 10

  def hi
    "Hi, I'm a #{self.class} object!"
  end

  def name
    "Hi, I'm #{@name}"
  end
end

class MyClass
  include MyModule

  def class_variable
    @@test
  end

  def initialize(name)
    @name = "namench"
  end

  attr_accessor :name
end

p test = MyClass.new("Jose") # <MyClass:[object id encoding], @name = "namench">
p test.hi                    # "Hi, I'm a MyClass object!"  => self.class calls the object and invokes on it the class method
p test.class_variable        # 10                           => gets @@test from MyModule after not finding it in MyClass
p test.name                  # "namench"                    => MyClass#name takes precedence over MyModule#name
p MyClass::TEST              # 100                          => checks in MyModule after not finding it in MyClass



module MyModule1
  def name
    "Hi, I'm #{@name}"
  end

  def class_variable
    @@test
  end
end

class MyClass1
  include MyModule1
  @@test = 10

  def initialize(name)
    @name = "namench"
  end
end

p test = MyClass1.new("Jose") # <MyClass:[object id encoding], @name = "namench">
#p test.class_variable        # Error because there isn't a class variable defined in MyModule1
p test.name                 # "Hi, I'm namench"

#Caveat: scope of instance vs class variables
# Instance variables have the scope of the object. Thus, a module can have an instance method that calls an instance variable it hasn't defined — if it's been defined elsewhere accessible by the object
# Conversely, class variables have a scope of their class and its ascendents. Thus, if we call a class method in a class or module that isn't defined there or in one of its ancestors it returns an error



class MyAncestor
  def name
    "Hi, I'm #{@name}"
  end

  def class_variable
    @@test
  end
end

class MyClass2 < MyAncestor
  @@test = 10

  def initialize
    @name = "namench"
  end
end

class MyClass3 < MyClass2
  def class_variable
    @@test
  end
end

p test = MyClass2.new         # <MyClass:[object id encoding], @name = "namench">
#p test.class_variable        # Error because there isn't a class variable defined in MyAncestor
p test.name                   # "Hi, I'm namench"
p MyClass3.new.class_variable # 10 => because class variable is accessible from ancestors to descendents, but not vice-versa


module MyModule2
  TESTING = 100
end

class MyClass4
  #TESTING = 200
end

p MyModule2::TESTING



class MyClass5
  @@name = "Jose"
  @@age = 24

  def name
    @@name
  end

  def age
    @@age
  end
end

class YourClass < MyClass5
end

class HisClass < MyClass5
  @@name = "Vahid"
  @@age = 21
end

test = MyClass5.new
p test.name        # Vahid because HisClass reassigns @@name and they both point to the same object
p test.age         # Error because @@age hasn't been initialized in MyClass5 or its ancestors // 21 if @@age is defined because HisClass reassigns to 21

test = YourClass.new
p test.name        # Vahid because it inherits the getter method and class variable from MyClass5
p test.age         # Error because @@age hasn't been initialized in MyClass5 or its ancestors

test = HisClass.new
p test.name  # Vahid
#p test.age   #  Error because age hasn't been initialized in MyClass5 or its ancestors


=begin

Insights
- Class variables are accessible in the class or module they're defined and their descendents — but not their ascendants
  - If a class variable is called outside its scope, it returns an error
  - The value of the class variable is the last assignment (includes siblings)
- Instance variables have the scope of the object
  - By extension, if an instance variable is called by an ancestor who hasn't initialized it (but its descendent has) it isn't an issue because it's an existing state of the object
- Modules can create and store constants, class and instance variables, and class and instance methods
  - Caveat: the scope of the constant is the class or module it's defined in and its descendents
  - Implication: constants can be inherited and they're called by the lookup chain
- Critical: a class overrides another regardless of whether an object's been instantiated or not

=end


module MyModule
  TEST = 1
  @@test = 10
  def initialize
    @test = 100
  end
  test = 1000
end

class MyClass
  TEST = 2
  @@test = 20
  def initialize
    @test = 200
  end
  test = 2000
  include MyModule
  def test
    @@test
  end
end

MyClass.new.test # 20


class Square
  def initialize
    @marker = :left
  end

  def to_s
    @marker
  end
end

puts Square.new # #<Square:0x00007fb240054638>
