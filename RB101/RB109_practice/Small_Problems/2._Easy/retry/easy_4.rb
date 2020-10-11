require "byebug"

# # Return short + long `short

# def short_long_short(str1, str2)
#   return str1 + str2 + str1 if str1.length < str2.length
#   str2 + str1 + str2
# end

# p short_long_short('abc', 'defgh') == "abcdefghabc"
# p short_long_short('abcde', 'fgh') == "fghabcdefgh"
# p short_long_short('', 'xyz') == "xyz"

# # Determine centiry

# # a. Year to century
# # b. Add suffix based on year

# def year_to_century(year)
#   (year.to_f / 100).ceil
# end

# def add_century_suffix(century_string)
#   if century_string.length >= 2 && ["11", "12", "13"].include?(century_string[-2..-1])
#     return century_string + "th"
#   else
#     case century_string[-1]
#     when "1" then century_string + "st"
#     when "2" then century_string + "nd"
#     when "3" then century_string + "rd"
#     else
#       century_string + "th"
#     end
#   end
# end

# def century(year)
#   century_string = year_to_century(year).to_s
#   add_century_suffix(century_string)
# end

# p century(2000) == '20th'
# p century(2001) == '21st'
# p century(1965) == '20th'
# p century(256) == '3rd'
# p century(5) == '1st'
# p century(10103) == "102nd"
# p century(1052) == '11th'
# p century(1127) == '12th'
# p century(11201) == '113th'



# # Leap years

# def gregorian_leap_year?(year)
#   return true if year % 400 == 0
#   return false if year % 100 == 0
#   year % 4 == 0
# end



# # English leap years!

# def leap_year?(year)
#   year >= 1752 ? gregorian_leap_year?(year) : year % 4 == 0
# end

# p leap_year?(2016) == true
# p leap_year?(2015) == false
# p leap_year?(2100) == false
# p leap_year?(2400) == true
# p leap_year?(240000) == true
# p leap_year?(240001) == false
# p leap_year?(2000) == true
# p leap_year?(1900) == false
# p leap_year?(1752) == true
# p leap_year?(1700) == true
# p leap_year?(1) == false
# p leap_year?(100) == true
# p leap_year?(400) == true



# # Sum multiples of 3 and 5

# def multisum(integer)
#   (1..integer).select { |num| num % 3 == 0 || num % 5 == 0 }.sum
# end

# p multisum(3) == 3
# p multisum(5) == 8
# p multisum(10) == 33
# p multisum(1000) == 234168


# # Running totals: transform the array to display their running totals

# def running_total(array)
#   value = 0
#   array.map { |ele| value += ele }
# end

# p running_total([2, 5, 13]) == [2, 7, 20]
# p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
# p running_total([3]) == [3]
# p running_total([]) == []



# # String to number!

# def string_to_integer(string)
#   result = 0
#   counter = string.length
#   string.each_char do |char|
#     result += char_to_int(char) * (10 ** (counter - 1))
#     counter -= 1
#   end
#   result
# end

# def char_to_int(char)
#   case char.ord
#   when 48 then 0
#   when 49 then 1
#   when 50 then 2
#   when 51 then 3
#   when 52 then 4
#   when 53 then 5
#   when 54 then 6
#   when 55 then 7
#   when 56 then 8
#   when 57 then 9
#   end
# end

# p string_to_integer('4321') == 4321
# p string_to_integer('570') == 570


# # Signed string to number!

# def string_to_signed_integer(string)
#   case string[0]
#   when "-" then -string_to_integer(string[1..-1])
#   when "+" then string_to_integer(string[1..-1])
#   else
#     string_to_integer(string)
#   end
# end

# p "==="
# p string_to_signed_integer('4321') == 4321
# p string_to_signed_integer('-570') == -570
# p string_to_signed_integer('+100') == 100


# # NUmber to string!

# DIGITS = [*0..9]

# def integer_to_string(integer)
#   result = ""
#   loop do
#     integer, remainder = integer.divmod(10)
#     result.prepend(remainder.to_s)
#     break if integer == 0
#   end
#   result
# end

# p "==="
# p integer_to_string(4321) == '4321'
# p integer_to_string(0) == '0'
# p integer_to_string(5000) == '5000'


# # Signed number to string!

# def signed_integer_to_string(integer)
#   case integer <=> 0
#   when -1 then "-" + integer_to_string(-integer)
#   when 1 then "+" + integer_to_string(integer)
#   when 0 then "0"
#   end
# end

# p "==="
# p signed_integer_to_string(4321) == '+4321'
# p signed_integer_to_string(-123) == '-123'
# p signed_integer_to_string(0) == '0'





# Take 2 strings and return a string concatenation

def short_long_short(str1, str2)
  str1.length > str2.length ? str2 + str1 + str2 : str1 + str2 + str1
end

p short_long_short('abc', 'defgh') == "abcdefghabc"
p short_long_short('abcde', 'fgh') == "fghabcdefgh"
p short_long_short('', 'xyz') == "xyz"

# Determine the century
# Convert year to century
# Appen ending

def year_to_century(year)
  (year.to_f / 100).ceil
end

def century(year)
  century_string = year_to_century(year).to_s
  append_ending(century_string)
end

def append_ending(century_string)
  if century_string.length > 1 && ["11", "12", "13"].include?(century_string[-2, 2])
    return century_string + "th"
  else
    case century_string[-1]
    when "1" then century_string + "st"
    when "2" then century_string + "nd"
    when "3" then century_string + "rd"
    else
      century_string + "th"
    end
  end
end

p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'




# Leap year: Gregorian

def leap_year?(year)
  return true if year % 400 == 0
  return false if year % 100 == 0
  year % 4 == 0
end

p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
p leap_year?(240001) == false
p leap_year?(2000) == true
p leap_year?(1900) == false
p leap_year?(1752) == true
p leap_year?(1700) == false
p leap_year?(1) == false
p leap_year?(100) == false
p leap_year?(400) == true


# English leap years

def leap_year?(year)
  if year >= 1752
    return true if year % 400 == 0
    return false if year % 100 == 0
    year % 4 == 0
  else
    year % 4 == 0
  end
end

p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
p leap_year?(240001) == false
p leap_year?(2000) == true
p leap_year?(1900) == false
p leap_year?(1752) == true
p leap_year?(1700) == true
p leap_year?(1) == false
p leap_year?(100) == true
p leap_year?(400) == true


# Add multiples of 3 && 5 between 1..integer

def multisum(integer)
  [*1..integer].select { |num| num % 3 == 0 || num % 5 == 0 }.sum
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168


# Running totals of the array (transformation)

def running_total(array)
  counter = 0
  array.map { |ele| counter += ele } # Wrote "count" => returned an error
end

p "==="
p running_total([2, 5, 13]) == [2, 7, 20]
p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
p running_total([3]) == [3]
p running_total([]) == []



# String to number
# Use Ascii characters to convert string to ints

def string_to_integer(string)
  result = 0
  counter = string.length
  string.each_char do |char|
    result += char_to_int(char) * (10 ** (counter - 1))
    counter -= 1
  end
  result
end

def char_to_int(char)
  case char.ord
  when 48 then 0
  when 49 then 1
  when 50 then 2
  when 51 then 3
  when 52 then 4
  when 53 then 5
  when 54 then 6
  when 55 then 7
  when 56 then 8
  when 57 then 9
  end
end

p string_to_integer('4321') == 4321
p string_to_integer('570') == 570


def string_to_signed_integer(string)
  case string[0]
  when "-" then -string_to_integer(string[1..-1])
  when "+" then string_to_integer(string[1..-1])
  else
    string_to_integer(string)
  end
end


p string_to_signed_integer('4321') == 4321
p string_to_signed_integer('-570') == -570
p string_to_signed_integer('+100') == 100


# Number to string!

DIGITS = [*"0".."9"]

def integer_to_string(integer)
  result = ""
  loop do
    integer, remainder = integer.divmod(10)
    result.prepend(DIGITS[remainder])
    break if integer == 0
  end
  result
end

p integer_to_string(4321) == '4321'
p integer_to_string(0) == '0'
p integer_to_string(5000) == '5000'


def signed_integer_to_string(integer)
  case integer <=> 0
  when 0 then "0"
  when 1 then "+" + integer_to_string(integer)
  when -1 then "-" + -integer_to_string(-integer)
  end
end

p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'