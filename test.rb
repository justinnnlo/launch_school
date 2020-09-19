require "byebug"
def difference_of_two(array)
  sorted_array = array.sort
  result = []
  sorted_array.each do |ele|
    result << [ele, ele + 2] if sorted_array.include?(ele + 2)
  end

  result
end

p difference_of_two([1, 2, 3, 4]) ==  [[1, 3], [2, 4]]
p difference_of_two([4, 1, 2, 3]) == [[1, 3], [2, 4]]
p difference_of_two([1, 23, 3, 4, 7]) == [[1, 3]]
p difference_of_two([4, 3, 1, 5, 6]) == [[1, 3], [3, 5], [4, 6]]
p difference_of_two([2, 4]) == [[2, 4]]
p difference_of_two([1, 4, 7, 10, 13]) == []

=begin
Array#combination: creates a new array with nested arrays containing all combinations.
Default is 1, but can be done with more

def difference_of_two(array)
  array.combinations(2)
=end