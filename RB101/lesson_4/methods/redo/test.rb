require "byebug"

# Problem: create a new array of integer strings that are odd from an original array.

# Examples

%w(1 2 3 4 5) # => ["1", "3", "5"]
['2', '3', '5', '7', '8', '11', '13', '15', '18'] # => ["3", "5", "7", "11", "13", "15"]

# Data types: object is an array with elements that are integer-strings that need to be converted to integers to see if they're odd
# Note: is not a method and doesn't need to return anything


# 3.
numbers = [7, 3, 5, 2, 1, 8, 4]
counter = numbers.size

loop do
  number = numbers[-counter]
  # numbers[-7] is correct?

  for num in 1..number
    puts num
  end

  break if counter == 1
  counter -=1
end

=begin
1. Initialize counter to 0
2. Break if counter == length of mailing_campaign_leads
3. Initialize full_name with the info from the hash.
4. Initialize names by splitting full_name and initialize names_counter to 0
5. Create a loop that breaks if names_counter == names.size

Loop 1: ensure it repeats until all leads have been covered
Loop 1.2: capitalize all names

Loop 2: ensure it repeats until all leads have been covered
Loop 2.2: usable_leads array should have all the leads that have logged in in the last 59 days AND are subscribed
=end



# Exam mistakes!

# 2: mistook iterator counter for the element in the iterator
numbers = ['2', '3', '5', '7', '8', '11', '13', '15', '18']
odd_numbers = []
number = 0

until number == numbers.size
  odd_numbers << numbers[number] if number.to_i.odd?

  number += 1 # Key: number != array element
end

# 7: The block will not execute the same number of times as the number of elements passed if the object is mutated

# 8. #select that is passed { true } will NOT return the original object — it'll return a new object with the same items. Similar logic for related methods like reject

# 9. 1) #map and #collect perform the same function (and both return an enumerator if no block is passed) and 2) Hash#map returns an array

# 17. See # 8, same logic for reject

# 19. See # 9: thought select would create a new hash,

arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]

test = arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end # => [[1, 8, 9], [1, 8, 11], [2, 6, 13], [2, 12, 15]]
p test