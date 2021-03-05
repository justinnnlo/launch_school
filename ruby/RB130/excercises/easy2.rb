require "byebug"
=begin
Create an instance method that imitates Range#step

- Input: starting value, ending value, step value and explicit block (if passed)

Algorithm:
- counter = start
  - While counter < end
    - If block: pass parameter to block
    - Increase by step
    - 
=end

def step(start, finish, step, &block)
  counter = start

  while counter <= finish
    block.call(counter)
    counter += step
  end
end

p step(1, 10, 3) { |value| puts "value = #{value}" }



=begin

Imitate Array#zip
Assumption: both arrays have the same number of arguments

Input: 2 arrays
Output: One array with the same number of subarrays as number of elements in the input arrays

Algorithm:
- Initialize a new empty array
- for i in 0..arr.length
  - Append to the new array a subarray with the elements of the 2 arrays
- Return the new array

=end

def zip(arr1, arr2)
  new_array = []

  for i in (0...arr1.length)
    new_array << [arr1[i], arr2[i]]
  end

  new_array
end

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]



=begin

Imitate Array#map

- If the Array is empty, return an empty array
- The new array should have the values of the return values of the block
  - Iterate through each element of the array
  - Pass the current element to the block
  - Append to the new array the result of the block
- Return the new array
=end

def map(array)
  new_array = []

  for ele in array
    new_array << yield(ele)
  end

  new_array
end

def map(array)
  array.each_with_object([]) { |ele, obj| obj << yield(ele) }
end

def map(array)
  new_array = []

  array.each { |ele| new_array << yield(ele )}

  new_array
end

def map(array)
  new_array = []
  counter = 0

  while counter < array.size
    new_array << yield(array[counter])
    counter += 1
  end

  new_array
end

def map(array)
  new_array = []
  counter = 0

  until counter == array.size
    new_array << yield(array[counter])
    counter += 1
  end

  new_array
end

def map(array)
  new_array = []
  counter = 0

  loop do
    break if counter == array.size
    new_array << yield(array[counter])
    counter += 1
  end

  new_array
end

def map(array)
  array.inject([]) { |acc, ele| acc << yield(ele) }
end

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
p map([]) { |value| true } == []
p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]



=begin

Create a count method that can be passed in a block

- Pass an unlimited number of parameters
- If no parameters are passed, return 0
- The block determines the count

Algorithm
- Return 0 if the array is empty
- Iterate from 0 to array size
- Create a counter
- Increase the counter by 1 if yield returns true
=end

def count(*args)
  counter = 0

  for ele in args
    counter += 1 if yield(ele)
  end

  counter
end

def count(*args)
  args.inject(0) { |acc, ele| yield(ele) ? acc + 1 : acc }
end

def count(*args)
  args.each_with_object([0]) { |ele, obj| yield(ele) ? obj[0] += 1 : obj }[0]
end

p count(1, 3, 6) { |value| value.odd? } == 2
p count(1, 3, 6) { |value| value.even? } == 1
p count(1, 3, 6) { |value| value > 6 } == 0
p count(1, 3, 6) { |value| true } == 3
p count() { |value| true } == 0
p count(1, 3, 6) { |value| value - 6 } == 3



=begin

Imitate the Enumerator#drop_while method

Gist: iterate until the block returns false. Then return an array of that and every succeeding element that hasn't been iterated through.

- Return an empty array if the array is empty or the block always returns true

Algorithm
- Create a variable with value false
- Create an empty array
- Iterate through each elements
  - If the block returns false, reassign the variable to true
  - That and every succeeding element is added in the array
- Return the array
=end

def drop_while(array)
  index = array.length
  result = []
  #byebug
  for num in (0...array.size)
    if !yield(array[num])
      index = num
      break
    end
  end

  for num in (index...array.size)
    result << array[num]
  end

  result
end

def drop_while(array)
  index = array.length

  for num in (0...array.size)
    if !yield(array[num])
      index = num
      break
    end
  end

  array[index..-1]
end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []



=begin

Create a new each_with_index

Input: a calling array and a block
Output: the same array

Algorithm
- Loop through the array elements
  - Pass to yield the current element and the index
- Return the calling array

=end

def each_with_index(array)
  for num in (0...array.size)
    yield(array[num], num)
  end

  array
end

def each_with_index(array)
  counter = 0
  loop do
    break if counter == array.size
    yield(array[counter], counter)
    counter += 1
  end

  array
end

def each_with_index(array)
  counter = 0

  while counter < array.size do
    yield(array[counter], counter)
    counter += 1
  end

  array
end

def each_with_index(array)
  counter = 0

  until counter == array.size do
    yield(array[counter], counter)
    counter += 1
  end

  array
end

def each_with_index(array)
  array.inject(0) do |acc, ele|
    yield(ele, acc)
    acc + 1
  end

  array
end

result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]



=begin

Create an Enumerable#each_with_object

Problem:
- Iterate over the members of a collection
  - Pass each element and an arbitrary object to the block
    - Object defined as a method parameter
  - Value returned by the object is not used
- Return the object

Algorithm
- Iterate through each element of the array
  - Pass to yield the element and the object
- Return the object

=end

def each_with_object(arr, obj)
  for ele in arr
    yield(ele, obj)
  end
  obj
end

def each_with_object(arr, obj)
  arr.each { |ele| yield(ele, obj) }
  obj
end

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result == {}



=begin

Problem:
- Iterate through the members of a collection, passing each to the block
- Return the element for which the block returns the largest value

Algorithm
- Create 2 variables: return value and result
- Iterate through each collection element
  - If return value > block return value, keep the result
  - Else, the current array element is the result
- Return the result

=end

def max_by(arr)
  result = arr[0]

  for ele in arr
    result = ele if yield(ele) > yield(result)
  end

  result
end

def max_by(arr)
  result = arr[0]

  arr.each { |ele| result = ele if yield(ele) > yield(result) }

  result
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil



=begin

Problem:
- Iterate over the members of a collection by taking a sequence of 2 consecutive elements at a time and passing them to the associated block
  - Return nil

Algorithm
- Iterate through elements 0 to the next to last element, with the index
  - Pass two elements at a time
  - Yield both elements
- Return nil
=end

def each_cons(array)
  for num in (0...array.size - 1)
    yield(array[num], array[num+1])
  end
  nil
end

def each_cons(array)
  array.each_with_index do |ele, idx|
    yield(array[idx], array[idx+1])
    break if idx == array.size - 2
  end
  nil
end

hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end
p result == nil
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
result = each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash == {}
p result == nil

hash = {}
result = each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash == {'a' => 'b'}
p result == nil

=begin

Problem:
- Same as above, but with an unlimited number of elements

Algorithm
- Iterate through elements 0 to the next to last element, with the index
  - If step == 1
    - Yield with 1 parameter
  - If step == 2
    - Yield with 2 parameters as integer elements
  - If step > 2
    - Yield with 2 parameters: value 1 and an undefined number of values as an array
- Return nil
=end

def each_cons(array, step)
  array.each_with_index do |ele, idx|
    break if idx == array.size - step + 1
    yield(*array[idx...idx+step])
  end
  nil
end

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
p hash #== {}

=begin

The "splat" (*) operator
- Allows us to work with an undefined number of arguments

https://medium.com/@sologoubalex/parameter-with-splat-operator-in-ruby-part-1-2-a1c2176215a5
=end