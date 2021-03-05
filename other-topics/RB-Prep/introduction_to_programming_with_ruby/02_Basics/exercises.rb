# 1. Add two strings together that, when concatenated, return your first and last name as your full name in one string.

"Jose" + " de la Puente"

# 2. Use the modulo operator, division, or a combination of both to take a 4 digit number and find the digit in the: 1) thousands place 2) hundreds place 3) tens place 4) ones place

p "The number is #{num = rand(1000..9999)}"

# Insight: using division gives you the left-most number, while using modulo gives you the remainder

p "Thousands: #{num/1000}" # thousands
p "Hundreds: #{num/100 % 10}" # hundreds
p "Tens: #{num % 1000 % 100 / 10}" #tens
p "Ones: #{num % 1000 % 100 % 10}" #ones

# 3. Write a program that uses a hash to store a list of movie titles with the year they came out. Then use the puts command to make your program print out the year of each movie to the screen.

movies = { jaws:1999, Matrix:2001, Mio_Cid: 1959, Ben_Hur: 1976}

puts "These are the years these movies were released: \n#{movies.values.join("\n")}"

# 4. Use the dates from the previous example and store them in an array. Then make your program output the same thing as exercise 3.
arr = movies.values

puts "These are the years these movies were released, for the second time but using a for loop:"
for i in (0...arr.length)
  puts "#{i+1}. #{arr[i]}"
  puts arr[i].class
end

# 5. Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.

# Using inject's accelerator for convenience

def factorial(n)
  (1..n).inject { |acc, e| acc * e   }
end

p "The factorial of 5 is #{factorial(5)}"

# 6. Write a program that calculates the squares of 3 float numbers of your choosing and outputs the result to the screen.

puts "The square of 9.1 is #{9.1 * 9.1}"
puts "The square of 3.9 is #{3.9 * 3.9}"
puts "The square of 4.5 is #{4.5 * 4.5}"

# 7. What does the following error message tell you?

=begin
SyntaxError: (irb):2: syntax error, unexpected ')', expecting '}'
from /usr/local/rvm/rubies/ruby-2.5.3/bin/irb:16:in `<main>'

Conclusion: a hash lacks a closing }
=end
