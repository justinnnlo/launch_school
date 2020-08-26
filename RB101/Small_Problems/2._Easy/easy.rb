# 1. Write a method that takes two arguments, a string and a positive integer, and prints the string as many times as the integer indicates.

def repeat(string, integer)
  integer.times { puts string }
end

repeat("Hello!", 5)

# 2. Write a method that takes one integer argument, which may be positive, negative, or zero. This method returns true if the number's absolute value is odd. You may assume that the argument is a valid integer value.

def is_odd?(integer)
  return integer.abs % 2 == 1
end

puts is_odd?(5)
puts is_odd?(2)
puts is_odd?(-9)

# 3. Write a method that takes one argument, a positive integer, and returns a list of the digits in the number.

def digit_list(integer)
  array = integer.to_s.split("")
  array.map { |ele| ele.to_i }
end

p digit_list(12345) == [1,2,3,4,5]

# 4. Write a method that counts the number of occurrences of each element in a given array. The words in the array are case-sensitive: 'suv' != 'SUV'. ` Once counted, print each element alongside the number of occurrences.

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

def count_occurrences(vehicles)
  hash_vehicles = Hash.new(0)
  vehicles.each { |ele| hash_vehicles[ele] += 1 }
  hash_vehicles.each { |key, value| puts "#{key} => #{value}" }
end

puts count_occurrences(vehicles)

# 5. Write a method that takes one argument, a string, and returns a new string with the words in reverse order.

def reverse_words(string)
  split_sentence = string.split
  reversed_words = []
  split_sentence.each { |word| reversed_words.unshift(word) }
  split_sentence.inject { |word| acc }
  reversed_words.join(" ")
end

p reverse_words("Hello!")

# 6. Write a method that takes one argument, a string containing one or more words, and returns the given string with words that contain five or more characters reversed. Each string will consist of only letters and spaces. Spaces should be included only when more than one word is present.

