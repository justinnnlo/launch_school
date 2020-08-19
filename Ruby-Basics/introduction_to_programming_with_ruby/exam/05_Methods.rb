# 1. Write a method named print_me that prints "I'm printing within the method!" when invoked.

# Gist: creating a simple method without an argument, printing within a method

def print_me
  puts "I'm printing within the method!"
  
  # returns nil because that's the return value of nil
end

print_me



# 2. Write a method named print_me that returns "I'm printing the return value!" when using the following code.

# Gist: understanding return within methods and how we can manipulate that value

def print_me
  return "I'm printing the return value!" # Method ALWAYS return something - here we're explicitly saying what it is
end

puts print_me



# 3. Write two methods, one that returns the string "Hello" and one that returns the string "World". Then print both strings using #puts, combining them into one sentence.

# String interpolation of methods

def hello
  "Hello" # Implicit return
end

def world
  "World" # Implicit return
end

puts "#{hello} #{world}" # Interpolating the string



# 4. Write a method named greet that invokes the following methods and outputs "Hello World" when invoked with puts

# String concatanation of methods, calling methods for other methods, and how the placement of methods affects programexecution

def greet # Originally with arguments - NOT NEEDED: (hello, world)
  hello + " " + world # Same as above but with string CONCATENATION
end

# greet method, which calls hello and world, can be placed ABOVE hello and world
# However, neither of the 3 methods used can be below the puts that calls greet - it results in an error

def hello
  'Hello'
end

def world
  'World'
end

puts greet # Calling methods within methods



# 5. Write a method called car that takes two arguments and prints a string containing the values of both arguments.

def car(make, model)
  puts "#{make} #{model}"
end

car('Toyota', 'Corolla')

=begin
Further exploration

1. What if puts is removed from car?
Answer: print with the reurn value of car and place puts/print/p before calling car

2. How do the return values of car differ with and without the #puts?
Answer: puts, like print, always returns nil. Methods implicitly return the last evaluated expression - so without puts car would return "Toyota Corolla"
=end



# 6. The variable below will be randomly assigned as true or false. Write a method named time_of_day that, given a boolean as an argument, prints "It's daytime!" if the boolean is true and "It's nighttime!" if it's false. Pass daylight into the method as the argument to determine whether it's day or night.

# Gist: variables with a variable value, conditionals within methods

def time_of_day(boolean)
  puts "It's daytime!" if boolean == true
  puts "It's nighttime!" if boolean == false
end

daylight = [true, false].sample

time_of_day(daylight)



# 7. Fix the following code so that the names are printed as expected.

# Gist: errors because method has the wrong number of arguments

def dog(name)
  return name
end

def cat(name)
  return name
end

puts "The dog's name is #{dog('Spot')}."
puts "The cat's name is #{cat('Ginger')}."



# 8. Write a method that accepts one argument, but doesn't require it. The parameter should default to the string "Bob" if no argument is given. The method's return value should be the value of the argument.

# Gist: assigning default values to method arguments

def assign_name(name = 'Bob') # Space BETWEEN the assignment symbol ('=')
  return name
end

puts assign_name('Kevin') == 'Kevin'
puts assign_name == 'Bob'



# 9. Write the following methods so that each output is true.

# Gist: Methods within methods, methods with implicit returns

def add(num_1, num_2)
  num_1 + num_2
end

def multiply(num_1, num_2)
  num_1 * num_2
end

puts add(2, 2) == 4
puts add(5, 4) == 9
puts multiply(add(2, 2), add(5, 4)) == 36



# 10. Write the method sentence that combines both values into a sentence and returns it from the method.

# Gist: passing methods within methods

def name(names)
  names.sample
end

def activity(activities)
  activities.sample
end

def sentence(name, activity)
  "#{name} went #{activity} today!"
end

names = ['Dave', 'Sally', 'George', 'Jessica']
activities = ['walking', 'running', 'cycling']

puts sentence(name(names), activity(activities))