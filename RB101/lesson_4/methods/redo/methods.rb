# 1. What is the return value of the select method below? Why?

[1, 2, 3].select do |num|
  num > 5
  'hi'   # true
end      # [1, 2, 3]

# Since each block iteration returns true, the method returns [1, 2, 3]

# 2. How does count treat the block's return value? How can we find out?

['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end # 2

# Documentation: returns an integer of each element that fits the criteria

# 3. What is the return value of reject in the following code? Why?

[1, 2, 3].reject do |num|
  puts num # => nil
end        # => [1, 2, 3]

# reject returns an array with all elements that return false in the block. As puts always returns nil (ie false), it returns [1, 2, 3]

# 4. What is the return value of each_with_object in the following code? Why?

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end # => { "a" => "ant", "b" => "bear", "c" => "cat" }

# each_with_object iterates through each element and returns a new object. In this case, the new object is a hash with the characteristics above.

# 5. What does shift do in the following code? How can we find out?

hash = { a: 'ant', b: 'bear' }
hash.shift # [:a, "ant"]
hash       # { :b => "bear" }
# shift eliminates the first element of the hash and returns the key value pair as an array

# 6. What is the return value of the following statement? Why?

['ant', 'bear', 'caterpillar'].pop.size # 11

# ['ant', 'bear', 'caterpillar'].pop => "caterpillar"
# "caterpillar".size == "caterpillar".length => 11

# 7. What is the block's return value in the following code? How is it determined? Also, what is the return value of any? in this code and what does it output?

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# Block's return value: true or false given the output of num.odd.
# Critical idea: any? has short circuiting! That's why 2 and 3 aren't printed.
# any? returns true

# 8. How does take work? Is it destructive? How can we find out?

arr = [1, 2, 3, 4, 5]
arr.take(2) # [1, 2]

# take returns a new array with the n number of elements from the array, working with an index system of 1 (element 1 = 1) rather than 0.
# Array#take is not destructive.

# 9. What is the return value of map in the following code? Why?

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end # [nil, "bear"]

# Unlike methods like #select, #map necessarily returns an element for every iteration.
# As "ant".size is < 3, the first iteration returns nil



# 10. What is the return value of the following code? Why?

[1, 2, 3].map do |num|
  if num > 1
    puts num # nil, nil because puts always returns nil
  else
    num      # 1
  end
end          # [1, nil, nil]