require "byebug"
# def solution(str)
#   str.split('').inject('') { |acc, char|  char + acc } # Inject can also work for string concatenations!s
# end


# Inject with ternary operator
# def getCount(inputStr)
#   vowels = ["a", "e", "i", "o", "u"]
#   inputStr.chars.inject(0) { |acc, char| vowels.include?(char.downcase) ? acc += 1 : acc }
# end


# Inject with strings: note to use as default value ("")
# def repeatStr(int, str)
#   (0...int).inject("") { |acc, _| acc + str }
# end

# def disemvowel(str)
#   vowels = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
#   str.chars.map { |char| vowels.include?(char) ? "" : char}.join("")
# end

# IMPORTANT! gsub vs delete!

# def disemvowel(str)
#   str.gsub(/[aeiouAeiou]/,"") # => Searches for each char
#   # str.gsub("aeiouAeiou","")   => Does not alter string because looks for EXACT match if string
# end

# def disemvowel(str)
#   str.delete("aeiouAeiou")    # => Unlike gsub, #delete works with a string of characters
#   # str.delete(/[aeiouAeiou]/)  => Error: delete does not implicitly convert regexp into string
# end

=begin
Need to practice: using the #each method with ranges
Error: did (0..-3) when -3 was meaningless — should've been (0..array.length-2)

def list(array)
  case array.length
  when 0 then ""
  when 1 then array[0][:name]
  when 2 then "#{array[0][:name]} & #{array[1][:name]}"
  else
    result = ""
    (array.length - 2).times { |num| result << array[num][:name] + ", " }
    (0..array.length-3).each { |num| result << array[num][:name] + ", " }
    result + "#{array[-2][:name]} & #{array[-1][:name]}"
  end
end

Analyze these 2 below

def list names
  names = names.map { |name| name[:name] }
  last_name = names.pop
  return last_name.to_s if names.empty?
  "#{names.join(', ')} & #{last_name}"
end

def list names
  names.map(&:values).join(', ').gsub(/, (\w+)$/, " & \\1")
end

p list([ {name: 'Bart'}, {name: 'Lisa'}, {name: 'Maggie'} ])
p list([ {name: 'Bart'}, {name: 'Lisa'} ])
p list([ {name: 'Bart'} ])
p list([])
=end

=begin
def panagram?(string)
  unused = [*"a".."z"]
  string.chars.each { |char| unused.delete(char.downcase) if unused.include?(char.downcase)} # Use delete to eliminate array elements
  unused.empty?
end

Comparisons!

def panagram?(s)
  ("A".."Z").to_a - s.upcase.chars == []
end

def panagram?(string)
  ('a'..'z').all? { |x| string.downcase.include? (x) }
end

def panagram?(string)
  string.downcase.scan(/[a-z]/).uniq.size == 26
end

p panagram?("The quick brown fox jumps over the lazy dog.")
p panagram?("The quick brown fox jumps over the ")
=end

=begin
def high_and_low(string)
  integers = string.split.map { |ele| ele.to_i }
  "#{integers.max} #{integers.min}"
end

OPTIMAL VERSION: use Enumerable#minmax
def high_and_low(string)
  string.split.map { |ele| ele.to_i }.minmax.reverse.join(" ")
end

p high_and_low("1 2 3 4 5")  # return "5 1"
p high_and_low("1 2 -3 4 5") # return "5 -3"
p high_and_low("1 9 3 4 -5") # return "9 -5"
=end

#Problem: find the sequence within an array that gives the largest sum.
#Algorithm: make all combinations of every size and keep the one with the largest sum
# Issues: made an algorithm to get the maximum sequence regardless of position — when it should be by sequence!

# def max_sequence_disorder(arr)
#   array = []
#   largest_sum = 0
#   (1..arr.length).each do |num|
#     arr.combination(num).to_a.each do |combination|
#       if combination.sum > largest_sum
#         largest_sum = combination.sum
#         array = combination
#       end
#     end
#   end
#   puts "#{largest_sum}: #{array}"
# end

# def max_sequence(arr)
#   array = []
#   largest_sum = 0

#   arr.each_with_index do |element, index|


# p max_sequence_disorder([11])
# p max_sequence_disorder([-2, 1, -3, 4, -1, 2, 1, -5, 4])

arr1 = [1, 2, 5, 7, 8, 3, 5, 9]
arr1.sort do |a, a2|
  byebug
  a2 <=> a
end