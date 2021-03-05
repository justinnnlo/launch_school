require "byebug"
=begin
Inputs: 2 arrays as arguments with the **same number of elements**
Output: new array that combines both arrays with the elements in alteration

Example:
n1 = [1, 2, 3]
n2 = %w(a b c)
result = [1, "a", 2, "b", 3, "c"]

Algorithm:
- Do each times as the length of n1
  - result << n1[num]
  - result << n2[num]
=end

def interleave(arr1, arr2)
  result = []
  
  arr1.length.times do |num|
    result << arr1[num]
    result << arr2[num]
  end
  result
end

p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']


=begin
Input: string
Output: hash with 3 pairs — the # of lowercase and uppercase characters, and the # that are neither

Algorithm:
  - Initialize 2 variables: upper and lower, with the respective upper and lowercase characters
  - Initialize the hash and assign the 3 possibilities a value of 0 to create the pair
  - Loop through the string
    - If statement: if the current character is upper, hash[uppercase] += 1
    - if lowercase, += 1
    - If neither, += 1
  - Return hash
=end

def letter_case_count(string)
  upper = [*"A".."Z"]
  lower = [*"a".."z"]
  hash = { lowercase: 0, uppercase: 0, neither: 0}

  string.each_char do |char|
    if upper.include?(char)
      hash[:uppercase] += 1
    elsif lower.include?(char)
      hash[:lowercase] += 1
    else
      hash[:neither] += 1
    end
  end

  hash
end

p letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
p letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
p letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
p letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }


=begin
Input: string
Output: new string capitalizing each word (first upper, rest lower)

Algorithm:
  - Split the string by spaces, assign that to "array" variable
  - array#map, iterating though each word and applying the #capitalize method
  - array#join the result
=end

def word_cap(string)
  array = string.split
  array.map { |word| word.capitalize }.join(" ")
end

p word_cap('four score and seven') == 'Four Score And Seven'
p word_cap('the javaScript language') == 'The Javascript Language'
p word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'


=begin

Input: string
Output: new string where every letter is replaced by its inverse case (lower to upper, upper to lower). All other characters unchanged!

Algorithm:
  - Initialize variable alphabet and bind to an array of all upper and lower characters
  - SPlit the string and call #map
    - If the character is included in alphabet
      - check its ordinal value
        If lowercase (> 96), decrease by 32 and call #chr on that
        If uppdercase (> 64), increase by 32 and call #chr on that
    - If not, return the same character to the block
  - Apply join(" ")
=end

def swapcase(string)
  alphabet = [*"a".."z"] + [*"A".."Z"]
  string.split("").map do |ele|
    if alphabet.include?(ele) == false
      ele
    else
      ele.ord > 96 ? (ele.ord - 32).chr : (ele.ord + 32).chr
    end
  end.join("")
end

#p swapcase('CamelCase') == 'cAMELcASE'
p swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'


=begin

Input: string
Output: new string with staggered capitalization
  - Every other character is capitalized and the other lowercase
  - Non-alphabetical char count to determine upper and lower case, but shouldn't be affected

Algorithm
  - Initialize the alphabet variable assigned to an array of all alphabetic char
  - Split string and call map with index
    - if index is even and the character is alphabetical, return the element in uppercase
    - if index is odd and the character is alphabetical, return the element in lowercase
    - if the element is not alphabetical, return the element
  - Join the result ("") and return

=end

def staggered_case(string)
  alphabet = [*"a".."z"] + [*"A".."Z"]
  string.split("").map.with_index do |ele, index|
    if alphabet.include?(ele)
      index.even? ? ele.upcase : ele.downcase
    else
      ele
    end
  end.join("")
end

p staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
p staggered_case('ALL_CAPS') == 'AlL_CaPs'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'


# Modify staggered_case so that non-alphabetic characters don't count towards determining the case
# Algorithm: use a counter to determine the index

def staggered_case(string)
  alphabet = [*"a".."z"] + [*"A".."Z"]
  counter = 0
  string.split("").map do |ele|
    if alphabet.include?(ele)
      counter += 1
      counter.odd? ? ele.upcase : ele.downcase
    else
      ele
    end
  end.join("")
end

p staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
p staggered_case('ALL CAPS') == 'AlL cApS'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'


=begin

Input: array of ints — assume non-empty
Output: float

Algorithm
- Use inject to multiply all the numbers
- Divide the result by the number of elements in the array
- Use format to print the result rounded to 3 decimals

=end

def show_multiplicative_average(array)
  result = (array.inject { |acc, ele| acc * ele }/array.length.to_f)
  format("The result is %.3f", result)
end

p show_multiplicative_average([3, 5])                # => The result is 7.500
p show_multiplicative_average([6])                   # => The result is 6.000
p show_multiplicative_average([2, 5, 7, 11, 13, 17]) # => The result is 28361.667


=begin

Input: 2 array arguments where each contains a list of numbers with the same number of elements
Output: new array that contains the product of each pair of the same index

Algorith: call map with index on either and multiply the elements

=end

def multiply_list(arr1, arr2)
  arr1.map.with_index { |_, i| arr1[i] * arr2[i] }
end

p multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]


=begin

Take 2 array arguments and return a new array with all multiplication combinations of the 2 arrays. Sort by increasing value.

Input: array
Output: array

Algorithm
  - Initialize a result variable and asign to an empty array
  - Do a 2 level each loops: iterate through array 1 and array 2, multiplying all of them and adding it to result
  - Sort result and return that

=end

def multiply_all_pairs(arr1, arr2)
  result = []
  arr1.each do |e1|
    arr2.each { |e2| result << e1 * e2 }
  end
  result.sort
end

p multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]


=begin

Input: string
Output: string

Problem: return the next to last word, will always contain at least 2 words

Algorithm
  - Split the string, assign it to "array" and return array's next to last element

=end

def penultimate(string)
  array = string.split(" ")
  array[-2]
end

p penultimate('last word') == 'last'
p penultimate('Launch School is great!') == 'is'