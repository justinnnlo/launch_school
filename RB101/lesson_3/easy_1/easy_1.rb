# 1. What is printed below?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers # [1, 2, 3, 3] because uniq doesn't mutate `numbers`
# IMPROVEMENT: puts prints each element in a newline because it automatically adds to_s 



# 2. Difference between `!` and `?` in Ruby?

=begin
1. What is != and where should you use it?:
Does not equal, and used when you want a boolean to return whether two items are identical or not.

2. put ! before something, like !user_name
Returns the inverse of its "truthiness". I.e., !"hi" => false because "hi" is truthy whereas !nil => true

3. put ! after something, like words.uniq!
`!` after a method usually, but not necessarily, means that the method will mutate the caller.

4. put ? before something

It is likely in a ternary operator, in which `?` evaluates an expression.

5. put ? after something
This typically refers to a method that will return a boolean value.

6. put !! before something, like !!user_name
This is used to return the truthiness of an object, be it true or false.

If it isn't an object, e.g. !!if, it will not return a boolean
=end

# 3. Replace the word "important" with "urgent" in this string:

advice = "Few things in life are as important as house training your pet dinosaur."
array = advice.split
array[6] = "urgent"
advice = array.join(" ")

p advice

# OPTIMIZED solution: using gsub

p advice.gsub!("urgent", "important") # Returns new string

# 4. What's the difference between `delete_at` and `delete` methods?

=begin
`delete_at`: mutates the array by deleting an element at an index
`delete`: removes the first instance of the element that's been passed to the method
=end

test = [*1..4]

puts test.delete_at(1) # => 2
p test

puts test.delete(1) # => 1
p test

# 5. Programmatically determine if 42 lies between 10 and 100.

# Alternatives

(10..100).include?(42)
[*10..100].include?(42)

# 6. Show two different ways to put the expected "Four score and " in front of the string.

famous_words = "seven years ago..."

puts "Four score and " + famous_words
puts "Four score and #{famous_words}"
puts famous_words.prepend("Four score and ") # Mutates the array
puts "Four score and " << famous_words # Mutates the object, even if it isn't bound to a value

# 7 Unnest the array

flintstones = ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
flintstones.flatten!

# Further exploration: how could we have mutated the array without nesting?

flintstones = ["Fred", "Wilma"]
flintstones << "Barney" << "Betty" << "BamBam" << "Pebbles" # Chain the << method

# 8. Turn this into an array with Barney´s name and number

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

flint_array = ["Barney", flintstones["Barney"]]

# Alternative: flintstones.assoc("Barney")