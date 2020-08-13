# 1. Write a program that prints a greeting message. This program should contain a method called greeting that takes a name as its parameter and returns a string.

def greeting(name)
  p "Hello, #{name}!"
end

greeting("Jose")

# 2. What do the following expressions evaluate to?

x = 2 # 2, because a method assignment returns the evaluated expression

puts x = 2 # prints 2 because that's the value returned by x = 2, a newline, and returns nil

p name = "Joe" # Both prints and returns "Joe"

four = "four" # Returns "four"

print something = "nothing" # Prints on the screen "nothing", but returns nil

# 3. Write a program that includes a method called multiply that takes two arguments and returns the product of the two numbers.

def multiply(a, b)
  a * b
end

p multiply(3, 4)

# 4. What will the following code print to the screen?

def scream(words)
  words = words + "!!!!"
  return # It prints and returns nothing because the explicit return stops the execution of the method 
  puts words
end

scream("Yippeee") 

# 5. Edit the method definition in exercise #4 so that it does print words on the screen. What does it return now?

def scream(words)
  words = words + "!!!!"
  puts words # prints Yippeee!!!! but returns nil
end

scream("Yippeee") 

# 6. What does the following error message tell you?

=begin

Conclusion: the user passed one instead of 2 arguments to the method

ArgumentError: wrong number of arguments (1 for 2)
  from (irb):1:in `calculate_product'
  from (irb):4
  from /Users/username/.rvm/rubies/ruby-2.5.3/bin/irb:12:in `<main>'
=end