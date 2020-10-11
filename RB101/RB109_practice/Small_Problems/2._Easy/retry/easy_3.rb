# 1. Ask the user to enter 6 numbers and say if it apepared in the first 5

array = []
puts "=> Enter the 1st number"
array << gets.chomp.to_i
puts "=> Enter the 2nd number"
array << gets.chomp.to_i
puts "=> Enter the 3rd number"
array << gets.chomp.to_i
puts "=> Enter the 4th number"
array << gets.chomp.to_i
puts "=> Enter the 5th number"
array << gets.chomp.to_i

puts "=> Enter the last number"
last = gets.chomp.to_i

if array.include?(last)
  puts "The number #{last} appears in #{array}"
else
  puts "The number #{last} does not appear in #{array}"
end

# 2. Prompt for 2 positive integers. Print the result of math operations between both.

puts "==> Enter the first number:"
first = gets.chomp.to_i

puts "==> Enter the second number:"
second = gets.chomp.to_i

puts "==> #{first} + #{second} = #{first + second}"
puts "==> #{first} - #{second} = #{first - second}"
puts "==> #{first} * #{second} = #{first * second}"
puts "==> #{first} / #{second} = #{first / second}"
puts "==> #{first} % #{second} = #{first % second}"
puts "==> #{first} ** #{second} = #{first ** second}"


# 3. Ask the user to input a word or multiple words and give back the number of characters, excluding spaces

puts "==> Write a string"
string = gets.chomp

arr = string.split(" ")
count_char = 0
arr.each { |ele| count_char += ele.length }

puts "There are #{count_char} characters in #{string}."



# 4. Take two integers, multiply them and return the result

def multiply(int1, int2)
  int1 * int2
end



# 5. Using the above method, create a new one that gets the square of the argument.

def square(integer)
  multiply(integer, integer)
end

# def nth_power(integer, power)
#   return multiply(integer, integer) if power == 2
#   nth_power(integer, power - 1) + nth_power(integer, power - 2)
# end

# 6. Make an exclusive or operator: only one of the 2 is truthy for true, not both.

def xor?(b1, b2)
  true if b1 == true && b2 == false || b1 == false && b2 == true
end



# 7. Pass an array. Return a new array where the index value of the element is odd

def oddities(array)
  new_array = []
  array.each_with_index { |ele, index| new_array << ele if index.even? }
  new_array
end



# 8. Make a case sensitive palindrome checker

def palindrome?(string)
  string == string.reverse
end



# 9. Case insensitive and alphaneumeric characters only palindrome checker

def real_palindrome?(string)
  valid = [*"a".."z"] + [*0..9]
  array = string.downcase.chars
  array.select! { |ele| valid.include?(ele) }
  array == array.reverse
end


# 10. Return true if the integer argument is a palindrome

def palindromic_number?(integer)
  integer.to_s == integer.to_s.reverse
end