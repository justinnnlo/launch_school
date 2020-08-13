# 1. Write down whether the following expressions return true or false

(32 * 4) >= 129 # false
false != !true # false
true == 4 # false
false == (847 == '874') # true
(!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false #true

# 2. Write a method that takes a string as argument. The method should return a new, all-caps version of the string, only if the string is longer than 10 characters. Example: change "hello world" to "HELLO WORLD".

def test(string)
  # Using a ternary operator
  string.length > 10 ? string.upcase : string
end

#3. Write a program that takes a number from the user between 0 and 100 and reports back whether the number is between 0 and 50, 51 and 100, or above 100.

num = gets.chomp.to_i

case num
when 51..100 
  p "Between 51 and 100"
when 0..50
  p "0 or larger"
else
  # case when statements can only make == comparisons — which is why this nested if is necessary
  if num > 100
    p "Above 100"
  else
    p "It's below 100!"
  end
end

# 4. What will each snippet print?

# Snippet 1
'4' == 4 ? puts("TRUE") : puts("FALSE") # FALSE

# Snippet 2
x = 2
if ((x * 3) / 2) == (4 + 4 - x - 3)
  puts "Did you get it right?" # prints this because 3 == 3
else
  puts "Did you?" 
end

# Snippet 3
y = 9
x = 10
if (x + 1) <= (y)
  puts "Alright."
elsif (x + 1) >= (y) 
  puts "Alright now!" # prints this because 11 >= 9, and due to flow control it stops evaluating the other statements below
elsif (y + 1) == x
  puts "ALRIGHT NOW!"
else
  puts "Alrighty!"
end

# 5. Identify and fix the error

def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
  end # The end statement was missing
end

equal_to_four(5)