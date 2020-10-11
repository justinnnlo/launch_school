NUMBERS = [*"0".."9"]

def clear
  system("clear") || system("cls")
end

# 1. Find if a number is found within an array

def get_num
  loop do
    num = gets.chomp
    return num.to_i if num.chars.all? { |num| NUMBERS.include?(num) }
    puts "You inserted an invalid number. Please enter your age again."
  end
end

def in_array?(array, num)
  return "The number #{num} appears in #{array}." if array.include?(num)
  "The number #{num} does not appear in #{array}."
end

array = []

puts "Enter the 1st number"
array << get_num

puts "Enter the 2nd number"
array << get_num

puts "Enter the 3rd number"
array << get_num

puts "Enter the 4th number"
array << get_num

puts "Enter the 5th number"
array << get_num

puts "Enter the 6th number"
num = get_num

puts in_array?(array, num)

# 2. Ask the user for 2 positive inputs and print a series of operations.

clear

def operations(num1, num2)
  puts num1 + num2
  puts num1 - num2
  puts num1 * num2
  puts num1 / num2
  puts num1 % num2
  puts num1 ** num2
end

puts "Enter the 1st number"
num1 = get_num

puts "Enter the 2nd number"
num2 = 0
loop do
  num2 = get_num
  break if num2 != 0
  puts "Please enter a number that is not 0."
end

operations(num1, num2)

# 3. Write a program that will ask a user for an input of a word or multiple words and give back the number of characters. Spaces should not be counted as a character.

puts "Please write word or multiple words:"
words = gets.chomp
words_length = words.split.join.length
puts "There are #{words_length} characters in \"#{words}\""

# 4. Create a method that multiplies 2 numbers

def multiply(a, b)
  a * b
end

multiply([1,2,3], 5) # => [1, 2, 3] * 5 = [1, 2, 3] + [1, 2, 3] + [1, 2, 3] + [1, 2, 3] + [1, 2, 3]
                      # = [1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3,]

# 4. Create a method to square an argument

def square(n)
  multiply(n, n)
end

square(5) == 25

# Exploration: power to the n method

def power(num, power)
  return 0 if power == 0
  return num if power == 1
  multiply(num, power(num, power - 1))
end

# 5. Exlusive OR: 

def xor?(arg1, arg2)
  (arg1 == true && arg2 == false) or (arg1 == false && arg2 == true)
end

p xor?(5.even?, 4.even?) == true
p xor?(5.odd?, 4.odd?) == true
p xor?(5.odd?, 4.even?) == false
p xor?(5.even?, 4.odd?) == false

# 6. Odd lists: Write a method that returns an Array that contains every
# other element of an Array that is passed in as an argument. The values
# in the returned list should be those values that are in the 1st, 3rd, 5th,
# and so on elements of the argument Array.

def oddities(array)
  array.select.with_index { |ele, index| index.even? }
end

# Further exploration: 2 additional ways + evenities

def evenities(array)
  array.select.with_index { |ele, index| index.odd? }
end

def oddities_v2(array)
  odd_elements = []
  for ele in (0...array.length)
    odd_elements << array[ele] if ele.even?
  end
  odd_elements
end

def oddities_v3(array)
  odd_elements = []
  index = 0

  while index <= array.length
    odd_elements << array[index] if index.even?
    index += 1
  end
  odd_elements
end

# 7. Palindrome checker

def palindrome?(word)
  word.to_s == word.to_s.reverse
end

# Further exploration: are the array elements all palindromes?

def palindrome_array?(array)
  array.all? { |ele| palindrome?(ele) == true }
end

# Further exploration: both palindromatic array and string

def palindrome_all?(element)
  element.all? { |ele| palindrome?(ele) == true } if element.class == Array
  element.to_s == element.to_s.reverse
end

# 8. Palindromic strings 2

def real_palindrome?(word)
  valid_inputs = [*"a".."z", *"A".."Z", *"0".."9"]
  alphanumerics_only_word = word.split.select { |ele| valid_inputs.include?(ele) }.join
  palindrome?(alphanumerics_only_word)
end

=begin
Interesting alternative

def real_palindrome?(string)
  string = string.downcase.delete('^a-z0-9') # Deletes all char except alphanumerics
  palindrome?(string)
end
=end

# 9. Palindrommix numbers

def palindromic_number?(num)
  return false if (num.class != Integer and num.class != Float)
  palindrome?(num.to_s.chars.join)
end

palindromic_number?(34543) == true
palindromic_number?(123210) == false
palindromic_number?(22) == true
palindromic_number?(5) == true