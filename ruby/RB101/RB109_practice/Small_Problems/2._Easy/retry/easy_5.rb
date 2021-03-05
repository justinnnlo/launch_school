require "byebug"
# def ascii_value(string)
#   count = 0
#   string.each_char { |char| count += char.ord }
#   count
# end

# # char.ord.mystery == char
# # Mystery is Integer#chr! #chr is the inverse of ord


# # 0 is midnight, and a positive number is after midnight and a negative before. Send an integer and get back a 24h format of the time

# def time_of_day(integer)
#   return positive_time_of_day(integer) if integer > 0
#   negative_time_of_day(integer) if integer < 0
# end

# def negative_time_of_day(integer)
#   hours, minutes = integer.abs.divmod(60)
#   hour_counter = 24
#   minute_counter = 60

#   hour_counter -= hours
#   minute_counter -= minutes

#   time_to_string(hours)+":"+time_to_string(minutes)
# end

# def positive_time_of_day(integer)
#   hours, minutes = integer.divmod(60)
#   hours = hours % 24 if hours > 34
#   time_to_string(hours)+":"+time_to_string(minutes)
# end

# def time_to_string(time)
#    time = case time
#           when 0
#             "00"
#           when 1
#             "01"
#           when 2
#             "02"
#           when 3
#             "03"
#           when 4
#             "04"
#           when 5
#             "05"
#           when 6
#             "06"
#           when 7
#             "07"
#           when 8
#             "08"
#           when 9
#             "09"
#           else
#             time.to_s
#           end
# end



# # 1440 minutes in a day
# # 24 hours and 60 minutes each — need to find a way to make the total minutes adjust to the hour/minute pair


# Problem: Convert an integer into a 24H time display

# Data structures: integer input, string output

# Algorithms:
# - Convert integer into hours and minutes using divmod
# - Adapt hours if hours > 24
# - If negative: subtract from time

# def integer_into_time(integer)
#   hours, minutes = integer.divmod(60)
#   hours = hours % 24 if hours > 24
#   hour_counter = 0
#   minutes_couter = 0

#   hour_counter += hours
#   minute_counter += minutes
#   return time_to_strings(hour_counter), time_to_strings(minute_counter)
# end

# def time_to_strings(integer)
#   case integer
#   when 0 then "00"
#   when 1 then "01"
#   when 2 then "02"
#   when 3 then "03"
#   when 4 then "04"
#   when 5 then "06"
#   when 6 then "06"
#   when 7 then "07"
#   when 8 then "08"
#   when 9 then "09"
#   else
#     integer
#   end
# end

# def time_of_day(integer)
#   hours, minutes = integer_into_time(integer)
# end

# p time_of_day(-3)
# p time_of_day(300)
# p time_of_day(3000)

# MINUTES_PER_HOUR = 60
# HOURS_PER_DAY = 24
# MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

# def time_of_day(delta_minutes)
#   delta_minutes = delta_minutes % MINUTES_PER_DAY # Work only with the remainder
#   hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR)
#   format("%02d:%02d", hours, minutes)
# end

# # Use contants to avoid mystery numbers in the method!


# MINUTES_PER_HOUR = 60
# HOURS_PER_DAY = 12
# MINUTES_PER_DAY = 1440

# def time_of_day(integer)
#   integer = integer % MINUTES_PER_DAY
#   hours, minutes = integer.divmod(60)
#   format("%02d:%02d", hours, minutes)
# end

# def after_midnight(time)
#   hours = time[0, 2]
#   minutes = time[3, 2]

#   return 0 if hours.to_i * MINUTES_PER_HOUR + minutes.to_i == 1400
#   hours.to_i * MINUTES_PER_HOUR + minutes.to_i
# end

# def before_midnight(time)

#   hours = time[0, 2]
#   minutes = time[3, 2]

#   return 0 if hours.to_i * MINUTES_PER_HOUR + minutes.to_i == 1400 || hours.to_i * MINUTES_PER_HOUR + minutes.to_i == 0
  
  
#   1400 - ((24 - hours.to_i) * MINUTES_PER_HOUR + minutes.to_i)
# end

# p after_midnight('00:00')
# p before_midnight('00:00')
# p after_midnight('12:34')
# p before_midnight('12:34')
# p after_midnight('24:00')
# p before_midnight('24:00')

# 1400


# ASCII string values: sum and return the total ascii values

def ascii_value(string)
  result = 0
  string.each_char { |char| result += char.ord }
  result
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0


# After midnight: take an integer and return the difference

MINUTES_PER_DAY = 1440
MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24

def time_of_day(integer)
  integer = integer % MINUTES_PER_DAY # ONly work with excess minutes, no redundancies
  hours, minutes = integer.divmod(MINUTES_PER_HOUR)
  format("%02d:%02d", hours, minutes)
end

p time_of_day(0) == "00:00"
p time_of_day(-3) == "23:57"
p time_of_day(35) == "00:35"
p time_of_day(-1437) == "00:03"
p time_of_day(3000) == "02:00"
p time_of_day(800) == "13:20"
p time_of_day(-4231) == "01:29"


# Take in the time and return the minutes before or after midnight

def after_midnight(string)
  hours = string[0, 2].to_i
  minutes = string[-2, 2].to_i

  hours = hours % HOURS_PER_DAY
  delta = hours * MINUTES_PER_HOUR + minutes
  return 0 if delta == 1440
  delta
end

p after_midnight('00:00') == 0
p after_midnight('12:34') == 754
p after_midnight('24:00') == 0

def before_midnight(string)
  hours = string[0, 2].to_i
  minutes = string[-2, 2].to_i

  hours = hours % HOURS_PER_DAY
  delta = 1440 - (hours * MINUTES_PER_HOUR + minutes)
  return 0 if delta == 1440
  delta
end

p before_midnight('00:00') == 0
p before_midnight('12:34') == 686
p before_midnight('24:00') == 0

# Letter swap: take the string and return a string in which the first and last letters of every  word are swapped. Every word has at least 1 letter and the string will contain at least 1 word. Nothing but spaces and words.

def swap(string)
  arr = string.split
  arr.map do |ele|
    if ele.length > 1
      ele[-1] + ele[1..-2] + ele[0]
    else
      ele
    end
  end.join(" ") # Works for words > 1
end

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'



# If given a string with lowecase words and non-alphabetic characters, how do you return a string that replaces the non-alphabetic characters as spaces?

def cleanup(string)
  valid = [*"a".."z"]
  string.chars.map do |ele|
    if valid.include?(ele)
      ele
    else
      " "
    end
  end.join("")
end

p cleanup("---what's my +*& line?") == ' what s my line '

# OPTIMIMUM SOLUTION: string"gsub => look into this



# Letter counter: Take a string of words separated by spaces and return a hash with keys as the length of thw words and value as the # words with said length

def word_sizes(string)
  hash = Hash.new { 0 }
  string.split.each { |word| hash[word.length] += 1 }
  hash
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
p word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
p word_sizes('') == {}


# Letter counter 2: modify the above method to exclude non-letter when determining word size

def word_sizes(string)
  hash = Hash.new { 0 }
  valid = [*"a".."z"] + [*"A".."Z"]
  string.split.each do |word|
    length = 0
    word.each_char { |letter| length += 1 if valid.include?(letter) }
    hash[length] += 1
  end
  hash
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
p word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
p word_sizes('') == {}


# Alphabetical numbers: Take an array of intes between 0 and 19 and return an array of whose ints are sorted based on the English words for each number

WORDS = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]

def alphabetic_number_sort(array)
  array.sort_by { |num| WORDS[num] }
end

p alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]



# Daily double: Take a string and return a new string containing the value of the original string collapsing duplicate characters into 1.

def crunch(string)
  text = string.dup
  text.each_char.with_index do |char, index|
    if text[index] == text[index + 1]
      text[index] == ""
    end
  end

end