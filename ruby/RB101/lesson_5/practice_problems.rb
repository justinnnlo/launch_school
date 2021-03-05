require "byebug"

# 1. How would you order this array of number strings by descending numeric value?

arr = ['10', '11', '9', '7', '8']

arr.sort { |a, b| b.to_i <=> a.to_i }

# Two key ideas: 1. inverse sorting and 2. string to integer conversion

# 2. How would you order this array of hashes based on the year of publication of each book, from the earliest to the latest?

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

books.sort_by do |ele|
  ele[:published]
end

# Two key ideas: i) retrieve the published date of each book and ii) symbols != strings

# 3. For each of these collection objects demonstrate how you would reference the letter 'g'.

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
arr1[2][1][3] # => "g"

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
arr2[1][:third].first       # => "g"
arr2[1].values.first.first  # => "g"
arr2[1].values.flatten.first  # => "g"
# Why are we invoking `.first` twice? Why can `Array#flatten` substitute for `Array#first`? Because `values` returns the result within an array!

arr3 = [['abc'], ['def'], {third: ['ghi']}]
arr3[2][:third][0][0]
arr3[2][:third][0][-3]
# [0] is needed to access "ghi" within the array!

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
hsh1["b"].last
hsh1["b"][1]
hsh1["b"][-1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
hsh2[:third].keys[0]
# [0] needed because `Hash#keys` returns an array!

# 4. For each of these collection objects where the value 3 occurs, demonstrate how you would change this to 4.

arr1 = [1, [2, 3], 4]
arr1[1][1] += 1
arr1[1][1] = 4

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] += 1
arr2[2] = 4

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4
hsh1[:first][2][0] += 1
hsh1.values[0][2][0] += 1
# An additional [0] after values in the last because it returns an array

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[["a"]][:a][2] = 4
hsh2[["a"]][:a][2] += 1
hsh2[["a"]][:a][-1] = 4
# hsh2[["a"]][:a].last = 5 => DOES NOT work because last only retrieves the value — it can't reassign it

# 5. figure out the total age of just the male members of the family.

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

total_age = 0
munsters.each { |_, values| total_age += values["age"] if values["gender"] == "male" }

# 6. Given this previously seen family hash, print out the name, age and gender of each family member:

# (Name) is a (age)-year-old (male or female).

munsters.each do |_, values|
  puts "#{_} is a #{values["age"]}-year-old #{values["gender"]}"
end

# 7. Given this code, what would be the final values of a and b? Try to work this out without running the code.

a = 2
b = [5, 8]
arr = [a, b]    # => [2, [5, 8]]

arr[0] += 2     # => [4, [5, 8]]
arr[1][0] -= a  # => [4, [1, 8]]
# WRONG! Why? `arr[0] += 2` reassigned the value of `arr[0]`, NOT the value of `a`!

# 8. Using the each method, write some code to output all of the vowels from the strings.

vowels = "aeiou"

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |_, values|
  values.each do |word|
    word.each_char { |char| puts char if vowels.include?(char) }
  end
end

# Key idea: We need to iterate across 3 levels: i) the value of each key, ii) the individual elements of each value array, iii) the individual characters of each element

# 9. Given this data structure, return a new array of the same structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |subarray|
  subarray.sort { |a, b| b <=> a}
end

# Key ideas: i) map to return a new array, ii) subrarray iteration, and ii) inverse sorting within the subarrays

# 10. Given the following data structure and without modifying the original array, use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.

[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |ele|
  ele.map do |key, value|
    [key, value + 1]
  end.to_h  # Should NOT be flattened
end

=begin
Many findings
1. Arrays converted to hashes need to be nested.
- {a:5}.to_a => [[a,5]]
- [a,5].to_h => Error
- [[a,5]].to_h => {a:5}

2. Hash#map only returns the modified elements
{a: 1}.map do |key, value|
  value + 1
end => [2]

{a: 1}.map do |key, value|
  value + 1
end.to_h => Error

{a: 1}.map do |key, value|
  [key, value + 1]
end => [[:a, 2]] because map adds another array around the block's result

{a: 1}.map do |key, value|
  [key, value + 1]
end.to_h => {a: 1}
=end

# 11. Given the following data structure use a combination of methods, including either the select or reject method, to return a new array identical in structure to the original but containing only the integers that are multiples of 3.

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

arr.map do |subarray|
  subarray.select { |integer| integer % 3 == 0}
end

# 12. Given the following data structure, and without using the Array#to_h method, write some code that will return a hash where the key is the first item in each sub array and the value is the second item.

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

hash = Hash.new
arr.each do |subarray|
  hash[subarray[0]] = subarray[1]
end

# 13. Given the following data structure, return a new array containing the same sub-arrays as the original but ordered logically by only taking into consideration the odd numbers they contain.

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
# => [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

arr.sort_by do |subarray|
  subarray.select { |num| num.odd? }
end

# Key ideas: i) sort_by when not using 2 arguments, ii) select to avoid using even numbers

# 14. Given this data structure write some code to return an array containing the colors of the fruits and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

hsh.map do |_, value|
  if value[:type] == "fruit"
    value[:colors].map { |color| color.capitalize }
  else
    value[:size].upcase
  end
end

# 15. Given this data structure write some code to return an array which contains only the hashes where all the integers are even.

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

arr.select do |hsh|
  hsh.values.flatten.all? { |num| num.even? }
end

# Key ideas: i) iterate through each hash element, ii) get the values of each hash, iii) flatten the values to make it easy to analyze each int, iv) invoke all? to ensure they're all even.

# 16. Write a method that returns one UUID when called with no parameters.

def uuid
  characters = [*"0".."9"] + [*"a".."f"]

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each do |num|
    num.times { uuid << characters.sample }
    uuid << "-" if num != sections.last
  end

  uuid
end

p uuid



order_data = [
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 351, order_date: '12/04/16', order_fulfilled: true, order_value: 135.99},
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 383, order_date: '12/04/16', order_fulfilled: true, order_value: 289.49},
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 392, order_date: '01/10/17', order_fulfilled: false, order_value: 58.00},
  {customer_id: 32, customer_name: 'Michael Richards', order_id: 241, order_date: '11/10/16', order_fulfilled: true, order_value: 120.00},
  {customer_id: 32, customer_name: 'Michael Richards', order_id: 395, order_date: '01/10/17', order_fulfilled: false, order_value: 85.65},
  # rest of data...
]

customer_orders = [
  {
    customer_id: 12,
    customer_name: 'Emma Lopez',
    orders: [
      { order_fulfilled: true, order_value: 135.99 },
      { order_fulfilled: true, order_value: 289.49 },
      { order_fulfilled: false, order_value: 58.00 }
    ]
  },
  {
    customer_id: 32,
    customer_name: 'Michael Richards',
    orders: [
      { order_fulfilled: true, order_value: 120.00 },
      { order_fulfilled: false, order_value: 85.65 }
    ]
  },
  # rest of data...
]

2 collections:
1. addition of all order values
2. Addition of all order_fulfilled values

all_orders =[
  {customer_id: 12, customer_name: 'Emma Lopez', total_order_value: 483.48},
  {customer_id: 32, customer_name: 'Michael Richards', total_order_value: 205.65},
  # rest of data
]

fulfilled_orders =[
  {customer_id: 12, customer_name: 'Emma Lopez', order_value: 425.48},
  {customer_id: 32, customer_name: 'Michael Richards', order_value: 120.00},
  # rest of data
]