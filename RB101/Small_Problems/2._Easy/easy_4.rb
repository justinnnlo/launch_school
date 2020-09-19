require "byebug"
# 1.

# input and output: strings
# Algorithm: i) compara the length of both strings, ii) return the concatenation of the short + long + short string
# Assumption: different lengths, no mutation

def short_long_short(str1, str2)
  return str1 + str2 + str1 if str1.length < str2.length
  str2 + str1 + str2
end

p short_long_short('abc', 'defgh') == "abcdefghabc"
p short_long_short('abcde', 'fgh') == "fghabcdefgh"
p short_long_short('', 'xyz') == "xyz"

# 2. Take a year and return a string that begins with the century number and ends with either: st, nd, rd or th

# def century_suffix(integer)
#   string = integer.to_s
#   case string[-1]
#   when "1"
#     return "st"
#   when "2"
#     return "nd"
#   when "3"
#     return "rd"
#   else
#     return "th"
#   end
# end

# def ending(num)
#   case num.to_s.size
#   when 0
#     return "th"
#   when 1...3
#     return "st"
#   else
#     ending_chars((num.to_f/(10 ** (num.to_s.size - 1))).ceil)
#   end
# end



# def century(year)
#   string = year.to_s

  


=begin
0 => 0th
1 => 1st
101 => 2nd        (101/100).ceil
911 => 10th
2000 => 20th
2001 => 21st
2100 => 21st
2101 => 22nd
10_001 => 101st
1st
2nd
3rd
4th
5th
6th
7th
8th
9th
0th
=end



# 3. A leap year occurs if the year is divisible by 4 unless it's also divisible by 100 UNLESS that number is also divisible by 400 (ie, still leap). Assume year is greater than 0, and return a boolean.

def leap_year?(year)
  if year % 4 != 0
    return false
  elsif year % 100 == 0
    if year % 400 == 0
      return true
    else
      return false
    end
  else
    return true
  end
end

# OPTIMAL if solution

def leap_year?(year)
  if year % 400 == 0
    return true
  elsif year % 100 == 0
    return false
  else year % 4 == 0
    return true
  end
end

# OPTIMAL idiomatic solution

def leap_year?(year)
  year % 400 == 0 || (year % 4 == 0 and year % 100 != 0)
  year % 400 == 0 || year % 4 == 0 unless year % 100 == 0
end

p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
leap_year?(240001) == false
leap_year?(2000) == true
leap_year?(1900) == false
leap_year?(1752) == true
leap_year?(1700) == false
leap_year?(1) == false
leap_year?(100) == false
leap_year?(400) == true

arr = %w(array fudge marriachi lucuma senor)
arr.sort do |a, b|
  b[1] <=> a[1]
end
arr.sort do |a, b|
  byebug
  a[1] <=> b[1]
end
