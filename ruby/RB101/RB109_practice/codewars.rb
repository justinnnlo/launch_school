require "byebug"

# 8.Repeated Substring
# (https://www.codewars.com/kata/5491689aff74b9b292000334/train/ruby)
# 6 kyu
=begin
For a given nonempty string s find a minimum substring t and the maximum number k, such that the **entire string s is equal to t repeated k times**. The input string consists of lowercase latin letters. Your function should return a tuple (in Python) (t, k) or an array (in Ruby and JavaScript) [t, k]

Example #1:

for string

s = "ababab"
the answer is

["ab", 3]
Example #2:

for string

s = "abcde"
the answer is

because for this string "abcde" the minimum substring t, such that s is t repeated k times, is itself.

Problem:
  - Find how many times the string can be subdivided into substrings
  - The string (s) has to be equivalent to the substring (t) * times it appears (k)
  - If there isn't a substring, return [s, 1]
  - Assumption: no empty strings

Data types:
  - Input: string
  - Output: array of i) string and ii) integer

Algorithms:
  - If the string length is odd, return [s, 1]
  - If the string is even
    - Initialize variable "substring" to string[0]
    - Initialize variable count and bind to 1
    - Loop through the string
      - if substring == string[substring.length * count, substring.length]
        - Count += 1
        - return [substring, count] if substring.length * count == string.length - 1
      - Else
        -substring << string[substring.length+1]
        - return [substring, count] if substring.length * count == string.length - 1
    
    - If the variable == string[i, substring length]
      - Count += 1

  - Find all possible substrings, get their length, and check if substrings * (string.length/substring.length) == string
=end

def f(string)
  return [string, 1] if string.length.odd?

end

p f("ababab") == ["ab", 3]

# substring = "a"
# count = 1
# "a" == "b" #=> false
# substring = "a" << string[i]
# count = 1

# substring == string[substring.length * count, 2]# => true
# count += 1

# return [substring, count] if substring.length * count == string.length

# substring == string[substring.length * count, 2]# => true
# count += 1


# p f("abcde") == ["abcde", 1]
# p f("babababa") = ["ba", 4]
# p f("babade") = ["babade", 1]
# p f("dede") = ["de", 2]
# p f("dedded") = ["ded", 2]

[1, 2, 4, 3].sort do |a, bee|
  byebug
  a <=> bee
end

# 1 <=> 2 => -1
# 2 <=> 4 => -1
# 4 <=> 3 => 1 => switches places
# 2 <=> 3 => -1