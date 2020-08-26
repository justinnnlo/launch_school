# 1. Locate the ruby documentation for methods File::path and File#path. How are they different?

=begin
a. File::Path — returns the string representation of the path. Ie, the path as a string
b. File#path — returns the **pathname** used to create file as a string. This may not be the actual path to file!
=end


# 2. What will each of the 4 puts statements print?

require 'date'

puts Date.new               # ArgumentError -> WRONG, returns original date: -4712-01-01
puts Date.new(2016)         # 2016-01-01 -> CORRECT
puts Date.new(2016, 5)      # 2016-01-06 -> WRONG, iterates month rather than day to result 2016-05-01
puts Date.new(2016, 5, 13)  # 2016-06-14 -> WRONG -> new guess: 2016-05-13 -> 2nd guess is CORRECT

