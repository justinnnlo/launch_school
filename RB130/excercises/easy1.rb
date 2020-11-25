require "byebug"

class Tree
  include Enumerable

  def each
  end
end



def compute
  block_given? ? yield : "Does not compute."
end

p compute { 5 + 3 } == 8
p compute { 'a' + 'b' } == 'ab'
p compute == 'Does not compute.'


=begin
- Input: a sorted array of integers
- Output: a new array with all of the missing integers in order

- Examples:
  - [-3, -1] => [-2]
  - [-3] => []
  - [-4, -2, 3, 7] => [-3, -1, 0, 1, 2, 3, 4, 5, 6]
  - Assumption: no duplicate values

- Data structures: array and integers (maybe a range?)

- Algorithm
  - If less than 2 elements in the array, return an empty array
  - Initialize a new empty array
  - Iterate through from 0 to n - 1 elements of the array
    - Go through the range of n + 1 (current number + 1) ... nest n (next number)
    - Add each of those numbers to the new array
  - Return the new array
=end


def missing(array)
  return [] if array.size < 2

  missing_numbers = []

  for i in (0...array.size - 1)
    for n in ((array[i] + 1)...array[i + 1])
      missing_numbers << n
    end
  end

  missing_numbers
end

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []



=begin
Input: POSITIVE integer
Output: array of integers

Problem: return an array of all of the integers that are divisors (i.e., number / divisor == 0)

Examples:
- 1 => [1]
- 2 => [1, 2]
- 10 => [1, 2, 5, 10]

Algorithm
- Initialize an empty array
- Do a range of 1..number
  - If the number / current number == 0 append the number to the array
- Return the array
=end

def divisors(n)
  divisors = []

  for i in (1..n)
    divisors << i if n/i == n.to_f/i
  end

  divisors
end

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
#p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute



=begin
Problem: break a rot13 encription — replace a letter with the 13th letter after it in the alphabet
- Rotate each letter 13 places
- Sensitive to capitalization
- If the letter passes "Z/z", continue counting from "A/a"

Input: String
Output: string

Example:
- Nqn Ybirynpr => Ada Lovelace

Algorithm
- Capitalized: 65 to 90 (inclusive) => def rotate_uppercase
- Small caps: 97 to 122 (inclusive) => def rotate_downcase

- Start counter at 13
  - While counter does not equal 0, loop
    - while ascii character is below the limit, increase by 1
    - If it reaches the limit, reset to basecase ("A/a")
    - Decrease counter by 1

=end

def rotate_uppercase(char)
  counter = 13
  ascii_char = char.ord

  while counter != 0
    ascii_char = (ascii_char >= 90 ? 65 : ascii_char + 1)
    counter -= 1
  end

  ascii_char.chr
end

def rotate_downcase(char)
  counter = 13
  ascii_char = char.ord

  while counter != 0
    ascii_char = (ascii_char >= 122 ? 97 : ascii_char + 1)
    counter -= 1
  end

  ascii_char.chr
end

def decrypt_rot13(string)
  split_string = string.split
  decoded_string = []

  for name in split_string
    decoded_name = ""

    for i in (0...name.length)
      decoded_name << (name[i].ord < 91 ? rotate_uppercase(name[i]) : rotate_downcase(name[i]))
    end

    decoded_string << decoded_name
  end

  decoded_string.join(" ")
end

p decrypt_rot13("Nqn Ybirynpr")



=begin
Problem: create a new instance method that imitates Array#any

- Input: array
- Output: boolean
- Should stop iterating when the first true is returned by the block

Examples:
- any?([]) { |n| true } => false
- any?([1]) { |n| true } => true
- any?([1, 2, 3]) { |n| n > 4 } => false

Algorithm
- return false if array length == 0
- Iterate through each element of the array
 -  yield and pass the current element
  - If yield is true, break the loop and return true
  - Else, continue
- Return false

=end

def any?(array)
  return false if array.size == 0

  for ele in array
    return true if yield(ele)
  end

  false
end

p any?([1, 3, 5, 6]) { |value| value.even? } == true
p any?([1, 3, 5, 7]) { |value| value.even? } == false
p any?([2, 4, 6, 8]) { |value| value.odd? } == false
p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any?([1, 3, 5, 7]) { |value| true } == true
p any?([1, 3, 5, 7]) { |value| false } == false
p any?([]) { |value| true } == false



=begin
Problem: create a new instance method that imitates Array#all

- Input: array
- Output: boolean
- Should stop iterating when the first false is returned by the block

Examples:
- any?([]) { |n| true } => false
- any?([1]) { |n| true } => true
- any?([1, 2, 3]) { |n| n > 4 } => true

Algorithm
- return false if array length == 0
- Iterate through each element of the array
 -  yield and pass the current element
  - If yield is true, break the loop and return true
  - Else, continue
- Return false

=end

def all?(array)
  return true if array.size == 0

  for ele in array
    return false if !yield(ele)
  end

  true
end

p all?([1, 3, 5, 6]) { |value| value.odd? } == false
p all?([1, 3, 5, 7]) { |value| value.odd? } == true
p all?([2, 4, 6, 8]) { |value| value.even? } == true
p all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p all?([1, 3, 5, 7]) { |value| true } == true
p all?([1, 3, 5, 7]) { |value| false } == false
p all?([]) { |value| false } == true



=begin
Problem: create a method that imitates Array#none
=end

def none?(array)
  return true if array.size == 0

  for ele in array
    return false if yield(ele)
  end

  true
end

p none?([1, 3, 5, 6]) { |value| value.even? } == false
p none?([1, 3, 5, 7]) { |value| value.even? } == true
p none?([2, 4, 6, 8]) { |value| value.odd? } == true
p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p none?([1, 3, 5, 7]) { |value| true } == false
p none?([1, 3, 5, 7]) { |value| false } == true
p none?([]) { |value| true } == true



=begin
Problem: create a method that imitates Array#none
Return true if exactly ONE element is true

Collect returned values if array, then count true
=end

def one?(array)
  return false if array.size == 0
  returned_values = []

  for ele in array
    returned_values << yield(ele)
  end

  returned_values.count(true) == 1
end

p one?([1, 3, 5, 6]) { |value| value.even? }    == true
p one?([1, 3, 5, 7]) { |value| value.odd? }     == false
p one?([2, 4, 6, 8]) { |value| value.even? }    == false
p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p one?([1, 3, 5, 7]) { |value| true }           == false
p one?([1, 3, 5, 7]) { |value| false }          == false
p one?([]) { |value| true }                     == false



=begin
Problem: create a method that imitates Array#count
Create a counter
Increase counter +1 if yield returns true
Return counter at end
=end

def count(array)
  counter = 0

  for ele in array
    counter += 1 if yield(ele)
  end

  counter
end

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2