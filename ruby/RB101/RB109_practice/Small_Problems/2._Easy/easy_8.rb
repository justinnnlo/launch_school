require "byebug"
=begin

Input: array of ints
Output: int

Problem: Add 0..0, 0..1, 0..n where n = array.length

Algorithm
  - result = 0
  - loop from 0 to array length
    - result += array[0..n].sum where n is the counter

=end

def sum_of_sums(array)
  result = 0
  array.length.times { |n| result += array[0..n].sum }
  result
end

p sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
p sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
p sum_of_sums([4]) == 4
p sum_of_sums([1, 2, 3, 4, 5]) == 35


=begin

Ask the user for an input of 
- noun
- verb
- adjective
- adverb

Then put "Do you [verb] your [adjective} [noun] [adverb]? That0s hilarious!"

=end

def madlibs
  puts "Enter a noun:"
  noun = gets.chomp
  puts "Enter a verb:"
  verb = gets.chomp
  puts "Enter a adjective:"
  adjective = gets.chomp
  puts "Enter a adverb:"
  adverb = gets.chomp

  puts "Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!"
end

#madlibs


=begin

Input: string
Output: array of all the combinations from [0..0], [0..1], [0.. .n] where n is string length

Algorithm
  - Initialize result empty array
  - times beased on string.length
    - result << string[0..times]
  - return result

=end

def leading_substrings(string)
  result = []
  string.length.times { |n| result << string[0..n] }
  result
end

p leading_substrings('abc') == ['a', 'ab', 'abc']
p leading_substrings('a') == ['a']
p leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']



=begin

Input: string
Output: 1 dimensional array of all the string combinations

Problem: apply leading substrings from 0..n, 1..n, n..n

=end

def substrings(string)
  result = []
  string.length.times { |n| result += leading_substrings(string[n..-1]) }
  result
end

p substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]


=begin

PROBLEM: select only the substrings that are palindromic
  - Make it case sensitive! Count every character — including non-alphabetic. Strict palindrome!
  - Single characters are not considered palindromes

Input: string
Output: array of strings

Algorithm:
- Pass the string to substrings and bind it to "array"
- Create a method to identify a palindrome
  - Is it the same as its reverse?
  - If length == 1 return false
- Select array elements that are palindromes

=end

def palindrome?(word)
  return false if word.length <= 1
  word == word.reverse
end

def palindromes(string)
  array = substrings(string)
  array.select { |word| palindrome?(word) }
end

p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
p palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]


=begin

Input: a starting number and an ending number
Output: return nothing, print an element for each number between starting and ending

Algorithm
- (starting..ending).each 
- If the current number is divisible by 3: print "Fizz"
- If the current number is divisible by 5: print "Buzz"
- If the current number is divisible by both 3 and 5: print "FizzBuzz"
- Otherwise, print the number

=end

def fizzbuzz(starting, ending)
  (starting..ending).each do |num|
    if num % 3 == 0 && num % 5 == 0
      puts "FizzBuzz"
    elsif num % 3 == 0
      puts "Fizz"
    elsif num % 5 == 0
      puts "Buzz"
    else
      puts num
    end
  end
end

fizzbuzz(1, 15) # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz

=begin

Input: string
Output: new string

Algorithm
- Initialize result = ""
- Loop through each char of the string and do result << char * 2

=end

def repeater(string)
  result = ""
  string.each_char { |char| result << char * 2 }
  result
end

p repeater('Hello') == "HHeelllloo"
p repeater("Good job!") == "GGoooodd  jjoobb!!"
p repeater('') == ''


=begin

Modify the above to only double consonants

Algorithm
- Create an array consonants with the consonants (subtracting vowels)
- Loop as above but only do * 2 when the char is a consonant (both cases)

=end

def double_consonants(string)
  result = ""
  consonants = [*"a".."z"] - %w(a e i o u)
  string.each_char do |char|
    if consonants.include?(char.downcase)
      result << char * 2
    else
      result << char
    end
  end
  result
end

p double_consonants('String') == "SSttrrinngg"
p double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
p double_consonants("July 4th") == "JJullyy 4tthh"
p double_consonants('') == ""


=begin

Input: positive integer
Return: integer with the input's digits reversed
  - Note: exclude leading 0s

Algorithm
- string = integer.to_s
- Reverse trint, convert to int, and reverse again to eliminate leading 0s

=end

def reversed_number(integer)
  integer.to_s.reverse.to_i.to_s.to_i
end

p reversed_number(12345) == 54321
p reversed_number(12213) == 31221
p reversed_number(456) == 654
p reversed_number(12000) == 21 # No leading zeros in return value!
p reversed_number(12003) == 30021
p reversed_number(1) == 1


=begin

Input: non-empty string argument
Output: middle character or characters

Algorithm
  - If string length is odd: return string[string.length/2]
  - If string length is odd: return string[(string.length/2)-1..string.length/2]
=end

def center_of(string)
  return string[string.length/2] if string.length.odd?
  string[(string.length/2)-1..string.length/2]
end

p center_of('I love ruby') == 'e'
p center_of('Launch School') == ' '
p center_of('Launch') == 'un'
p center_of('Launchschool') == 'hs'
p center_of('x') == 'x'