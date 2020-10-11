# 1. Take i) a string and ii) a positive integer. Print the string as many times as the value of the integer. Assume return value is irrelevant and can be anything.

def repeat(string, integer)
  integer.times { puts string }
end

# 2. Take an integer argument. The method returns true if the integer is odd. Assume that the argument is a valid integer.

def is_odd?(integer)
  integer % 2 != 0
end

# 3. Tak a positive integer as an argument and return a list of each digit as an element of an array

def digit_list(integer)
  arr = integer.to_s.split("")  # equivalent to integer.to_s.chars => optimal
  arr.map { |num| num.to_i }    # arr.map(&:to_i)
end

# 4. Count the number of occurances of each method in an array

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

def count_occurrences(vehicles)
  hash = Hash.new { 0 }
  vehicles.each do |ele|
    hash[ele] += 1
  end
  hash.each { |key, value| puts "#{key} => #{value}"}
end

# 5. Take a string as an argument and return a new string with the WORDS in reverse order

def reverse_sentence(string)
  string.split(" ").reverse.join(" ")
end

# 6. Take a string as an argument and return a new string with the **sentence** in reverse order

def reverse_words(string)
  string.chars.reverse.join("")
end

# 7. Take a positive integer as a number and return a string of alternating 1s and 0s, starting with 1. ITs length shohuld match the integer.

def stringy(integer)
  string = ""
  integer.times do |num|
    string << "1" if num.even?
    string << "0" if num.odd?
  end
  string
end

# 8. Take an array containing integers as an argument and return the average of all numbers in the array. The array will never be empty and all numbers will be positive ints. Return an integer

def average(array)
  array.sum / array.length
end

# 9. Take a positive integer as an argument and return the sum of its digits

def sum(integer)
  result = 0
  integer.to_s.chars.each { |ele| result += ele.to_i }
  result
end

# NOTE: `result = nil` doesn't work because nil += doesn't exist!


# 10. Take a positive integer and a boolean. If the boolean is true, return half the value of the integer. Otherwise, return 0.

def calculate_bonus(salary, boolean)
  return salary * 0.5 if boolean
  0
end