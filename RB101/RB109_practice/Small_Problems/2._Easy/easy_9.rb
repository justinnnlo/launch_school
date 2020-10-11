require "byebug"
=begin
Inputs: array (2+ elements), hash (title and occupation)
Output: return a greeting — "Hello, [array.join(" ")]! Nice to have a [title] [occupation] around."
=end

def greetings(arr, hash)
  "Hello, #{arr.join(" ")}! Nice to have a #{hash[:title]} #{hash[:occupation]} around."
end

p greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })

=begin

Input: number
Output: a double number (its left side digits are exactly the same as its right side)
  Examples
    - 103103 NOT a palindrome like 403304
    - 44
    - 101

Algorithm
- Check if a number is a doubler
  - Convert to string
  - split string in 2
  - iterate and check if each element is equal
- If it's a doubler: return the number
- Else: return the number * 2

=end

def doubler?(integer)
  return false if integer.to_s.length % 2 == 1
  array = integer.to_s.chars
  arr1, arr2 = array.partition.with_index { |e, i| i < array.length/2 }
  result = true

  array.each_with_index do |e, i|
    result = false if arr1[i] != arr2[i]
  end

  result
end

def twice(integer)
  return integer if doubler?(integer)
  integer * 2
end

p twice(37) == 74
p twice(44) == 44
p twice(334433) == 668866
p twice(444) == 888
p twice(107) == 214
p twice(103103) == 103103
p twice(3333) == 3333
p twice(7676) == 7676
p twice(123_456_789_123_456_789) == 123_456_789_123_456_789
p twice(5) == 10


=begin

Input: integer
Output:
  - if a positive number: - number
  - If >= 0: number

=end

def negative(integer)
  integer > 0 ? -integer : integer
end

p negative(5) == -5
p negative(-3) == -3
p negative(0) == 0      # There's no such thing as -0 in ruby


=begin

Input: integer
Output: array of all integers from 1..integer

Assume the integer will always be > 1 and valid

Algorithm: Use 1.upto(integer) and pass each integer to an array

=end

def sequence(integer)
  result = []
  1.upto(integer) { |n| result << n }
  result
end

p sequence(5) == [1, 2, 3, 4, 5]
p sequence(3) == [1, 2, 3]
p sequence(1) == [1]


=begin

Input: string
Output: boolean

Algorithm
- Initialize alphabet variable
- Loop
  - If a character is in the alphabet
    - If the char is lowercase, stop and return false
    - Else, return true
  - If it isn't: go to the next


=end

def uppercase?(string)
  alphabet = [*"A".."Z"]

  string.each_char do |char|
    return false if alphabet.include?(char.upcase) && alphabet.include?(char) == false
  end
  true
end

p uppercase?('t') == false
p uppercase?('T') == true
p uppercase?('Four Score') == false
p uppercase?('FOUR SCORE') == true
p uppercase?('4SCORE!') == true
p uppercase?('') == true


=begin
Input: string
Output: array of characters

Assumptions: words separated by a single space

Algorithm:
  - If the string has length 0, return an empty array
  - Initialize array and assign to split string
  - Call map on the array, new element should be: "#ele #ele.length"

=end

def word_lengths(string)
  return [] if string.length == 0
  array = string.split(" ")

  array.map { |e| "#{e} #{e.length}" }
end

p word_lengths("cow sheep chicken") == ["cow 3", "sheep 5", "chicken 7"]

p word_lengths("baseball hot dogs and apple pie") ==
  ["baseball 8", "hot 3", "dogs 4", "and 3", "apple 5", "pie 3"]

p word_lengths("It ain't easy, is it?") == ["It 2", "ain't 5", "easy, 5", "is 2", "it? 3"]

p word_lengths("Supercalifragilisticexpialidocious") ==
  ["Supercalifragilisticexpialidocious 34"]

p word_lengths("") == []

=begin

Input: string of "firstname lastname"
Output: string of "last name, firstname"

Algorithm:
  - Split string and assign each part to firstname and last name
  - Output: "{lastname}, {firstname}"
  - Assumption: no empty or invalid strings
=end

def swap_name(string)
  firstname, lastname = string.split
  "#{lastname}, #{firstname}"

  # OPTIMUM solution:
  # string.split.reverse.join (", ")
end

p swap_name('Joe Roberts') == 'Roberts, Joe'


=begin
Input: 2 integers
  - Count
  - Number of a sequence

Output: array of integers

Algorithm
  - Return empty array if count is 0
  - Only reate elements of 0 if 0 is the number of the sequence
  - Else
    - NUmber of sequence should be the first number
    - Every other number should be the product of number + (number * index position)

=end

def sequence(count, number)
  return [] if count == 0
  result = []

  count.times do |n|
    result << number + (number * n)
  end
  result
end

p sequence(5, 1) == [1, 2, 3, 4, 5]
p sequence(4, -7) == [-7, -14, -21, -28]
p sequence(3, 0) == [0, 0, 0]
p sequence(0, 1000000) == []


=begin

Input: undefined number of integer within an array
Output: Letter string

Assumption: do not check for negative of > 100 values

Algorithm
  - define parameter as *grades
  - Add all values of grades and divide by the number of elements
  - Return a letter based on the averaged score

=end

def get_grade(*grades)
  grade_to_letter(grades.sum/grades.length)
end

def grade_to_letter(integer)
  case integer
  when (0...60) then "F"
  when (0...70) then "D"
  when (0...80) then "C"
  when (0...90) then "B"
  when (0..100) then "A"
  end
end

p get_grade(95, 90, 93) == "A"
p get_grade(50, 50, 95) == "D"


=begin

Input: array with nested arrays of format [string, number]
Output: 1D array — string * number

Algorithm:
- result = []
- array.each { result << string * element}

=end

def buy_fruit(array)
  result = []
  array.each { |e| e[1].times { |n| result << e[0] } }
  result
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]