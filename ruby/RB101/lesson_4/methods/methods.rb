# 1. What is the return value of the select method below? Why?

[1, 2, 3].select do |num|
  num > 5
  'hi'
end # [1, 2, 3] because select evaluates based on the value returned by the block

# 2. How does count treat the block's return value? How can we find out?

['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end # => 2

# Find out: by running the code or checking docs

# 3. What is the return value of reject in the following code? Why?

[1, 2, 3].reject do |num|
  puts num # => nil
end # [1, 2, 3]

# Returns a new array with the items in which the block is not true

# 4. What is the return value of each_with_object in the following code? Why?

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end # { "a" => "ant", "b" => "bear", "c" => "cat" }

# 5. What does shift do in the following code? How can we find out?

hash = { a: 'ant', b: 'bear' }
hash.shift # [:a, "ant"]
hash # { :b => "bear" }

# Assumption: based on how it works with strings, it'll eliminate the first key-value pair
# Docs: removes the first k-v pair and returns it as the 2-item array

# 6. What is the return value of the following statement? Why?

['ant', 'bear', 'caterpillar'].pop.size # 11

# Assumption: Ruby reads left-to-right and eliminates an element before counting
# Wrong: `.pop` returns the popped element, which is then counted by size as size 1 which is the answer.
# Wrong 2: `.size` on a string works as length and counts the number of characters

# 7. What is the block's return value in the following code? How is it determined? Also, what is the return value of any? in this code and what does it output?

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end # true

# Return value of the block: true or false if num is odd or not. Method returns true if at least one block returns true.

# 8. How does take work? Is it destructive? How can we find out?

arr = [1, 2, 3, 4, 5]
arr.take(2) # [1, 2]
arr # [1, 2, 3, 4, 5]

# Returns the first n elements of an array with ArgumentError if a negative number is given,
# No reference to whether its destructive or not

# 10. What is the return value of map in the following code? Why?

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end # [nil, "bear"]

# Returns a new array with the result of block. Why is `nil` there? Because unlike select map returns for every element, even if nil.

# 11. What is the return value of the following code? Why?

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end # [1, nil, nil] because puts returns nil