require "byebug"

def high(x)
  hash = {}
  x.split(/[ .-]/).each { |ele| hash[ele] = ele.chars.inject(0) { |acc, c| acc += c.ord - 96 }}
  hash.max_by { |_, v| v }[0] # Hash#max doesn't work!!!
end

p high('man i need a taxi up to ubud')


=begin

Input: integer
Output: string

Problem: break down an integer into its component parts

Examples:
  - 42 => 40 + 2
  - 74892 => 70000 + 4000 + 800 + 90 + 2

Data structure: use strings and their lengths

Algorithm
- string = integer.to_s
- length = string.length
- result = []
- Iterate through each character of string with index
    - result << (string[index] * 10 ** (length - 1)).to_s
    - length -= 1
- result.join(" + ")
=end

def expanded_form(num)
  num.to_s.chars.


  string = num.to_s
  length = string.length
  result = []

  string.each_char.with_index do |char, index|
    result << (string[index].to_i * 10 ** (length - 1)).to_s unless (string[index].to_i * 10 ** (length - 1)).to_s == "0"
    length -= 1
  end

  result.join(" + ")
end

p expanded_form(12)