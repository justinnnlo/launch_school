# Problem 1: gather immediate family members into a new array
family = {  
  uncles: ["bob", "joe", "steve"],
  sisters: ["jane", "jill", "beth"],
  brothers: ["frank","rob","david"],
  aunts: ["mary","sally","susan"]
}
a = []
family.select { |k, v| a << family[k] if k == :brothers or k == :sisters }
p a.flatten

# Problem 2: What is the difference between merge and merge!

# `merge!` mutates the caller while `merge` does not

a = family.select { |k, v| family[k] if k == :brothers or k == :sisters } # Keys and values of the sisters and brothers
p a
p a.merge(aunts: ["mary","sally","susan"])
puts ""
p "merge without mutating the caller — the hash remains the same #{a}"
puts ""
p a.merge!(aunts: ["mary","sally","susan"])
puts ""
p "merge! mutating the caller — the hash now includes the merged hash #{a}"

# Problem 3: loop through the hash and print i) the keys, ii) the values, and iii) both keys and values (one for each)

# Print only keys as an array
b = []
family.each { |k, v| b << k }
p b

# Print only values as an array
c = []

family.each { |k, v| c << v }
p c

# Print both keys and values as an array
d = []
e = []

family.each { |k, v| e << k && d << v }
p "The keys are: #{e}", "The values are: #{d}"

# Print straight to screen with another method that is not each

# Keys
family.each_key { |key| p key }

# Values
family.each_value { |value| p value }

# Problem 4: how would I access the person's name?

person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}

person[:name]

# Problem 5: What method could you use to find out if a Hash contains a specific value in it?

string = "Jose"

family.values.flatten.include?(string)

# Problem 6: What's the difference between the two hashes that were created in the following code?

x = "hi there"
my_hash = {x: "some value"} # Key: :x
my_hash2 = {x => "some value"} # Key: "hi there"

# Problem 7: If you see this error, what do you suspect is the most likely problem?

=begin
NoMethodError: undefined method `keys' for Array

A. We're missing keys in an array variable.

B. There is no method called keys for Array objects. —> Answer

C. keys is an Array object, but it hasn't been defined yet. 

D. There's an array of strings, and we're trying to get the string keys out of the array, but it doesn't exist.
=end

# Problem 8: Write a program that prints out groups of words that are anagrams. Anagrams are words that have the same exact letters in them but in a different order.
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
  'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
  'flow', 'neon']

# Solution 1: using 2 hashes for everything
hash = Hash.new(0)

words.each do |e|
  hash[e] = Hash.new(0)
  e.each_char { |c| hash[e][c] += 1 }
end

result = Hash.new([])

hash.each { |k, v| result[v] += [k] }

p result.values

# Solution 2: using an array to find and sort letters of words, and an array to match them
values = []
words.each { |e| values << e.split("").sort }

hash1 = Hash.new([])
values.each_with_index { |e, i| hash1[e] += [words[i]] }

p hash1.values











hash = Hash.new(Hash.new(0))

words.each do |e|
  hash[e] = Hash.new(0)
  e.each_char do |c|
    hash[e][c] += 1 # Can't be done without first creating the first key — hash[e] = Hash.new(0)
  end
end

results = Hash.new([])

# hash.each do |k, v|
#   # Insert key into an array if its value is repeat more than once
#   if hash.values.count(v) > 1
#     results << k
#   end
# end

hash.each { |k, v|  results[v] += [k] }

results.each { |k,v| p v if v.length > 1}