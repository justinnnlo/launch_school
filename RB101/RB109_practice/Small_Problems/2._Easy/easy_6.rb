require "byebug"
=begin
  Input: integer or float that represents an angle between 0º and 360º
  Output: string that represents the angle in degrees, minutes and seconds
    - Degrees should end with "º", minutes with "'" and seconds with "\""
    - A degree is 60 minutes and a minute has 60 seconds
  Algorithm
    - Take the input, make sure its a float and convert it to string. Then split it by its "." and assign the first part to "degrees" and the second to "remainder"
    - Do 60 (number of minutes in a degree) * 0.73 (% degree remaining). Then split the result by "." and assign the first half to "minutes" and the second to "seconds"
    - format("%º02%'02%\"", degrees, minutes, seconds)
=end

MINUTES_PER_DEGREE = 60
SECONDS_PER_MINUTE = 60
SECONDS_PER_DEGREE = MINUTES_PER_DEGREE * SECONDS_PER_MINUTE

def dms(degrees)
  total_seconds = (degrees * SECONDS_PER_DEGREE).round
  degrees, seconds = total_seconds.divmod(SECONDS_PER_DEGREE)
  minutes, seconds = seconds.divmod(SECONDS_PER_MINUTE)
  format('%d°%02d\'%02d"', degrees, minutes, seconds)
end

# Where did my problem below go wrong?

# def dms(degrees)
#   degrees, remainder = degrees.to_f.to_s.split(".")
#   #byebug
#   minutes, seconds = (remainder.to_f * 0.60).to_s.split(".")
#   format('%d°%02d\'%02d"', degrees.to_i, minutes.to_i, seconds.to_i * 6)
# end

puts dms(30) == %(30°00'00")
puts dms(76.73) == %(76°43'48")
puts dms(254.6) == %(254°36'00")
puts dms(93.034773) == %(93°02'05")
puts dms(0) == %(0°00'00")
puts dms(360) == %(360°00'00") || dms(360) == %(0°00'00")



=begin

Input: an array of strings, of length 1 or more
Output: an array of the same string but with their vowels removed (case insensitive!)

Algorithm: loop through each word and remove the vowels with gsub

=end

def remove_vowels(array)
  array.map { |ele| ele.gsub(/[aeiou]/i, "") }
end

puts remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
puts remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
puts remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']



=begin
Problem: return the first fibonacci with said number of digits

Input: integer
Output: integer of the fibonacci number that has the first number of digits specified in the output

Examples:
  - 2 => 7 because the first 2 digit number is 13 (the 7th fibonacci)
  - 3 => 12 because the first 3 digit number is 144 (the 12th fibonacci)

Algorithms
  - Create a fibonacci generator that creates fibonacci numbers
    - 3 variables: larger, smaller and temp. temp = larger, larger = larger + smaller, smaller = larger
    - Counter: increase by 1 in each iteration
  - Convert each number to a string, add them to an array, and check their length. If length == integer, return counter

=end

def find_fibonacci_index_by_length(integer)
  larger = 1
  smaller = 1
  counter = 2

  while larger.to_s.length != integer
    counter += 1
    temp = larger
    larger = larger + smaller
    smaller = temp
  end

  counter
end

puts find_fibonacci_index_by_length(2) #== 7          # 1 1 2 3 5 8 13
puts find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
puts find_fibonacci_index_by_length(10) == 45
puts find_fibonacci_index_by_length(100) == 476
puts find_fibonacci_index_by_length(1000) == 4782
puts find_fibonacci_index_by_length(10000) == 47847


=begin
Input: array

Output: 
  - mutated array that reverses its elements in place
  - If there's a middle element, it should remain in place

Algorithm
  - Create a copy of the array
  - Loop through the object, and replace each element with its negative
    - counter = -1
    - arr[0] = copy_array[counter]
    - counter -= 1
  - Return the object

=end

def reverse!(array)
  copy = array.clone
  array.each_with_index do |ele, i|
    array[i] = copy[-i-1]
  end
  array
end

puts list = [1,2,3,4]
puts result = reverse!(list)
puts result == [4, 3, 2, 1]
puts list == [4, 3, 2, 1]
puts list.object_id == result.object_id


# Do the same as above but without mutating the array

def reverse(array)
  array.map.with_index do |ele, i|
    array[-i-1]
  end
end

puts reverse([1,2,3,4]) == [4,3,2,1]          # => true
puts reverse(%w(a b e d c)) == %w(c d e b a)  # => true
puts reverse(['abc']) == ['abc']              # => true
puts reverse([]) == []                        # => true

puts list = [1, 3, 2]                      # => [1, 3, 2]
puts new_list = reverse(list)              # => [2, 3, 1]
puts list.object_id != new_list.object_id  # => true
puts list == [1, 3, 2]                     # => true
puts new_list == [2, 3, 1]                 # => true


# Take 2 arrays as arguments and return an array that contains all values without any duplicates. Assumption: order isn't necessary

def merge(arr1, arr2)
  result = []
  arr1.each { |ele| result << ele }
  arr2.each { |ele| result << ele }
  result.uniq
end

puts merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]

# Take an array as an argument and return 2 arrays: its first and second hald. If there's an odd number, the middle element should be in the first

# Algorithm: Create "even" and "odd" empty arrays. Go through each element of the array and assign based on index number

def halvsies(array)
  first = []
  second = []

  array.each_with_index do |e, i|
    if array.length.odd?
      i <= array.length/2 ? first << e : second << e
    else
      i < array.length/2 ? first << e : second << e
    end
  end

  [first, second]
end

p halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
puts halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
puts halvsies([5]) == [[5], []]
puts halvsies([]) == [[], []]


# Problem: find the duplicate value in the array
# Algorithm: initialize a hash with default 0 and count each occurance. Select the key with the value == 2

def find_dup(array)
  hash = Hash.new(0)

  array.each { |ele| hash[ele] += 1 }
  hash.select { |k, v| v == 2 }.keys[0]
end

p find_dup([1, 5, 3, 1]) == 1
p find_dup([18,  9, 36, 96, 31, 19, 54, 75, 42, 15,
          38, 25, 97, 92, 46, 69, 91, 59, 53, 27,
          14, 61, 90, 81,  8, 63, 95, 99, 30, 65,
          78, 76, 48, 16, 93, 77, 52, 49, 37, 29,
          89, 10, 84,  1, 47, 68, 12, 33, 86, 60,
          41, 44, 83, 35, 94, 73, 98,  3, 64, 82,
          55, 79, 80, 21, 39, 72, 13, 50,  6, 70,
          85, 87, 51, 17, 66, 20, 28, 26,  2, 22,
          40, 23, 71, 62, 73, 32, 43, 24,  4, 56,
          7,  34, 57, 74, 45, 11, 88, 67,  5, 58]) == 73


# Write include? which takes an array and a value. return true if the value is in the array, false if otherwise
# Algorithm: loop through the array with the #any? method.

def include?(array, value)
  array.any? { |ele| ele == value }
end

def include?(array, value)
  result = false
  counter = 0
  return false if array.length == 0
  result = loop do
    #byebug
            break true if array[counter] == value
            break false if counter == array.length - 1
            counter += 1
           end
end

p include?([1,2,3,4,5], 3) == true
p include?([1,2,3,4,5], 6) == false
p include?([], 3) == false
p include?([nil], nil) == true
p include?([], nil) == false


# Take an integer argument and display a right triangle whose sides have n stars
# Algorithm: print a line for each value of the number, cycling through all spaces and 1 star to all starts at the end

def triangle(integer)
  (integer+1).times do |num|
    puts "#{" " * (integer - num)}#{"*" * num}"
  end
end

triangle(5)
triangle(9)