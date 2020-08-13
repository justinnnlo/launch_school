# Problem 1: what do these expressions evaluate to?

(32 * 4) >= 129 # 128 >= 129 is false
false != !true # false != false is false
true == 4 # false, but it's be true if it were true == !!4
false == (847 == '874') # false == false is true
(!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false #true || false is true

# Problem 2: method should return a new, all-caps version of the string, only if the string is longer than 10 characters

def shout(string)
  if string.length > 10
    return string.upcase
  end
  return string
end

p shout("This is more than 10!!!")
p shout("Less")

# Problem 3: takes a number from the user between 0 and 100 and reports back whether the number is between 0 and 50, 51 and 100, or above 100

def where(n)
  if n > 100
    return "It's over 100!"
  elsif n < 0
    return "It's a negative number!"
  elsif n > 50
    return "It's between 51 and 100!"
  else
    return "It's between 0 and 50!"
  end
end

p where(51)
p where(5)
p where(510)
p where(-50)

# Problem 4: what does each code snipper print to the screen?

  # Snippet 1
  '4' == 4 ? puts("TRUE") : puts("FALSE") # Prints to screen "FALSE"

  # Snippet 2
  x = 2
  if ((x * 3) / 2) == (4 + 4 - x - 3)
    puts "Did you get it right?" # Prints to screen "Did you get it right?"
  else
    puts "Did you?"
  end

  # Snippet 3
  y = 9
  x = 10
  if (x + 1) <= (y)
    puts "Alright."
  elsif (x + 1) >= (y)
    puts "Alright now!" # Prints to screen "Alright now!"
  elsif (y + 1) == x    # true, but does not print as the above already did
    puts "ALRIGHT NOW!"
  else
    puts "Alrighty!"
  end

# Problem 5: you get this error message when you run the method below, how can you fix it? `exercise.rb:8: syntax error, unexpected end-of-input, expecting keyword_end`

def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope" # How to fix: the next line needs an `end` to stop the flow.
end

equal_to_four(5)