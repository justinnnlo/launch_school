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

## Constants: inheritance and scope

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

## Instance variables: inheritance and scope

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