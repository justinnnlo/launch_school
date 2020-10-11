# 1. Write a method that takes two arguments, a string and a positive integer,
# and prints the string as many times as the integer indicates.

def repeat(string, integer)
  integer.times { puts string }
end

repeat("Hello!", 5)

# 2. Write a method that takes one integer argument, which may be positive,
# negative, or zero. This method returns true if the number's absolute value
# is odd. You may assume that the argument is a valid integer value.

def is_odd?(integer)
  integer.abs % 2 == 1
end

puts is_odd?(5)
puts is_odd?(2)
puts is_odd?(-9)

# 3. Write a method that takes one argument, a positive integer, and returns
# a list of the digits in the number.

def digit_list(integer)
  integer.to_s.chars.map(&:to_i)

  # 12345.to_s.chars => %w(1 2 3 4 5)
end

p digit_list(12345) == [1, 2, 3, 4, 5]

# 4. Write a method that counts the number of occurrences of each element
# in a given array. The words in the array are case-sensitive: 'suv' != 'SUV'.
# Once counted, print each element alongside the number of occurrences.

vehicles = [
  'car', 'car', "CAR", 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

def count_occurrences(vehicles)
  hash_vehicles = Hash.new(0)
  vehicles = vehicles.map(&:downcase)
  vehicles.each { |ele| hash_vehicles[ele] += 1 }
  hash_vehicles.each { |key, value| puts "#{key} => #{value}" }
end

count_occurrences(vehicles)

# 5. Write a method that takes one argument, a string, and returns a new
# string with the words in reverse order.

def reverse_words(string)
  split_sentence = string.split
  reversed_words = []
  split_sentence.each { |word| reversed_words.unshift(word) }
  reversed_words.join(" ")

  # OPTIMIZED SOLUTION
  # string.split.reverse.join(" ")
end

p reverse_words("Hello World!")

# 6. Write a method that takes one argument, a string containing one or more
# words, and returns the given string with words that contain five or more
# characters reversed. Each string will consist of only letters and spaces.
# Spaces should be included only when more than one word is present.

def reverse_words_2(sentence)
  sentence.split.map { |word| word.reverse if word.length >= 5 }.join(" ")
end

# 7. Take a positive integer and return a string of alternative 1s and 0s,
# always starting with 1. The string length should match the integer.

def stringy(integer)
  result = ""
  (0...integer).each do |num|
    result << (num.even? ? "1" : "0")
  end
  result
end

puts stringy(5)

# 8. Array average: return the average of numbers in the array of integers passd
# as an argument. It will never be empty and all ints will always be positive.

def average(array)
  (array.sum / array.length).to_f
end

# 9. Sum of digits: return a sum of the digits of a number. E.g. 23 = 2 + 3

def sum_digits(integer)
  # My solution
  # result = 0
  # integer.to_s.chars.each { |digit| result += digit.to_i }
  # result

  # OPTIMIZED SOLUTION
  integer.to_s.chars.map(&:to_i).reduce(&:+)
end

def for_sum_digits(integer)
  result = 0
  array_digits = integer.to_s.chars
  for digit in (0...array_digits.length)
    result += array_digits[digit].to_i
  end

  result
end

# 10 Write a method that takes two arguments, a positive integer and a boolean,
# and calculates the bonus for a given salary. If the boolean is true, the bonus
# should be half of the salary. If the boolean is false, the bonus should be 0.

def calculate_bonus(salary, boolean)
  # My solution
  return 0 if boolean == false
  (salary * 0.5)

  # OPTIMIZED solution: ternary operator
  boolean ? (salary * 0.5) : 0
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000
