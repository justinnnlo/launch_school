require "byebug"
# Return the sum of all ASCII values in a string

def ascii_value(string)
  string.chars.inject(0) { |acc, ele| acc += ele.ord }
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0

# Take an integer and return the time in a string/24h format

HOURS_IN_DAY = 24
MINUTES_IN_HOUR = 60
MINUTES_IN_DAY = MINUTES_IN_HOUR * HOURS_IN_DAY

def time_of_day(integer)
  integer = integer % MINUTES_IN_DAY
  hours, minutes = integer.divmod(60)
  format("%02d:%02d", hours, minutes)
end

p time_of_day(0) == "00:00"
p time_of_day(-3) == "23:57"
p time_of_day(35) == "00:35"
p time_of_day(-1437) == "00:03"
p time_of_day(3000) == "02:00"
p time_of_day(800) == "13:20"
p time_of_day(-4231) == "01:29"

# Time of day for minutes before or after midnight!

def after_midnight(string)
  hours, minutes = string.split(":").map { |ele| ele.to_i }

  return 0 if (hours * MINUTES_IN_HOUR + minutes) == 1440
  hours * MINUTES_IN_HOUR + minutes
end

def before_midnight(string)
  hours, minutes = string.split(":").map { |ele| ele.to_i }

  return 0 if (1440 - hours * MINUTES_IN_HOUR + minutes) == 1440
  1440 - (hours * MINUTES_IN_HOUR + minutes)
end

p after_midnight('00:00') == 0
p before_midnight('00:00') == 0
p after_midnight('12:34') == 754
p before_midnight('12:34') == 686
p after_midnight('24:00') == 0
p before_midnight('24:00') == 0

# Return a string where the first and last letters of every word are swapped

def swap(string)
  array = string.split
  array.map do |ele|
    if ele.length == 1
      ele
    else
      ele[-1] + ele[1...-1] + ele[0]
    end
  end.join(" ")
end

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'

# Replace non-alphabetic words with spaces

def cleanup(string)
  valid = [*"a".."z"]
  cleaned_string = string.chars.map do |ele|
    if valid.include?(ele)
      ele
    else
      " "
    end
  end.join("")

  while cleaned_string.chars.map.with_index { |ele, index| cleaned_string[index] == " " && cleaned_string[index + 1] == " "}.any? { |ele| ele == true }
    (0...cleaned_string.length - 1).each do |index|
      cleaned_string[index] = "" if cleaned_string[index] == " " && cleaned_string[index + 1] == " "
    end
  end

  cleaned_string
end

p cleanup("---what's my +*& line?") == ' what s my line '

# Further exploration: do it using gsub





# Take a string with 1 or more spaced wors and return a hash that shows the # of wors of different sizes

def word_sizes(string)
  hash = Hash.new { 0 }
  string.split.each { |ele| hash[ele.length] += 1 }
  hash
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
p word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
p word_sizes('') == {}


# Word sizes with only alphabetical characters

def word_sizes(string)
  valid = [*"a".."z"] + [*"A".."Z"] + [" "]
  string = string.chars.select { |ele| valid.include?(ele) }.join
  hash = Hash.new { 0 }
  string.split.each { |ele| hash[ele.length] += 1 }
  hash
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
p word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
p word_sizes('') == {}

# Alphabetical numbers: take an array of ints between 0 and 19 and return the ints sorted based on the english words

def alphabetic_number_sort(array)
  numbers_as_words = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
  numbers_as_words = %w(zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen)

  array.sort_by { |ele| numbers_as_words[ele] }
end

p alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]

# Duther exploration: rewrite it using #sort



# Find the missing letter
# Write a method that takes an array of consecutive (increasing) letters as input and that returns the missing letter in the array.
#
# You will always get an valid array. And it will be always exactly one letter be missing. The length of the array will always be at least 2.
#
# The array will always contain letters in only one case.

# Example:
#
# ['a','b','c','d','f'] -> 'e'
# ['O','Q','R','S'] -> 'P'

# Use the English alphabet with 26 letters.


# Input: array of string characters
# Output: a single string character of hte missing character in the array
# Algorithm: looping through the array and finding when the ASCII count increases by more than 1. Insert that then.
# Potential pit falls: calling an index that doesn't exist (not a problem because the issue isn't at the end of the string)

def find_missing_letter(array)
  array.each_with_index do |e, i|
    if (e.ord + 1) == array[i + 1].ord
    else
      break (e.ord + 1).chr
    end
  end
end

# breaks can be used within each loop!

p find_missing_letter(["a","b","c","d","f"]) == "e"
p find_missing_letter(["O","Q","R","S"]) == "P"
p find_missing_letter(["b","d"]) == "c"
p find_missing_letter(["a","b","d"]) == "c"
p find_missing_letter(["b","d","e"]) == "c"


# Input: string; output: string with the alphabetical characters replaced by spaces BUT no more than one consecutive space
# Algorithm: i) replace all non-characters with spaces, ii)


def remove_duplicate_spaces(string)
  result = ""
  string.each_char.with_index do |c, i|
    break if i == string.length
    result << c unless string[i] == " " && string[i + 1] == " "
  end
  result
end

def remove_non_valid_characters(string)
  valid = [*"a".."z"] + [" "] + [*"A".."Z"]
  string.chars.map { |ele| valid.include?(ele) ? ele : " " }.join("")
end


def clean_string(string)
  string = remove_non_valid_characters(string) # Equivalent to: string.gsub(/[^a-z]/, " ")
  remove_duplicate_spaces(string)
end


# 2 possible solutions:
clean_string("---what's my +*& line?")
"---what's my +*& line?".gsub(/[^a-z]/, " ").squeeze(" ")



# Take a string and return a new string where all consecutive duplicate characters are collapsed into a single character
# Algorithm: create an empty string. Loop through the parameter. When the next character isn't identical, pass the current character to the new string.

def crunch(string)
  result = ""
  string.each_char.with_index do |c, i|
    break if i == string.length
    result << c if string[i] != string[i + 1]
  end
  result
end

p "==="
p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
p crunch('4444abcabccba') == '4abcabcba'
p crunch('ggggggggggggggg') == 'g'
p crunch('a') == 'a'
p crunch('') == ''


# Take a short line of text and print it within a box
# Left, right, top, bottom padding of 1
# When empty: print an empty box with a padding of 1 in both left and right

=begin
Input: string
Output: Multiple strings
  - Top and bottom line: "+" at the beginning and end with "-" * input length + 2
  - 2nd and 4th line: "|" at the beginning and end with " " * input length + 2
  - Middle (3rd) line: "|" at the beginning and end, with a space in either side of padding, and the text in the middle
=end

def print_in_box(string)
  puts "+-#{"-" * string.length}-+"
  puts "| #{" " * string.length} |"
  puts "| #{string} |"
  puts "| #{" " * string.length} |"
  puts "+-#{"-" * string.length}-+"
end

p print_in_box("")
p print_in_box('To boldly go where no one has gone before.')



=begin
Input: string
Output: string
Question: will the below impementation mutate the object passed to the method? Will it return the same or a new object?

No! Why? str.split creates a new object. It will also create a new object.
=end

def spin_me(str)
  str.split.each do |word|
    word.reverse!
  end.join(" ")
end