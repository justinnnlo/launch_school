# Problem 1: contain a method called `greeting` that takes a `name` as its parameter and returns a string

def greeting(name)
  return "Hello, #{name}!"
end

p greeting("Jose")

# Problem 2: what do these expressions evaluate to?
x = 2 # 2, because variable assignments return the value assigned to the variable

puts x = 2 # nil, because puts always *returns* nil

p name = "Joe" # Jose, because p returns the value of the evaluated expression

four = "four" # "four", because variable assignments return the value assigned to the variable

print something = "nothing" # nil, because print always *returns* nil (but without a newline before the returned value, unlike puts)

# Problem 3: Write a program that includes a method called `multiply` that takes two arguments and returns the product of the two numbers.

def multiply (a, b)
  return a * b
end

puts multiply(4, 2)

# Problem 4: what value is returned from this method call?

def scream(words)
  words = words + "!!!!"
  return
  puts words
end

scream("Yippeee") # nil, because it's returning nothing. Thus, it does not print any words to the screen.

# Problem 5: how can it both print its evalued expression to the screen and not return nil? How can it print to screen but not return?

def scream(words)
  words = words + "!!!!"
  # return — delete return so that it returns the next line
  p words #use p instead of puts to return words. Use puts or print to print to screen but return nil.
end

scream("Yippeee") # output to screen AND return words