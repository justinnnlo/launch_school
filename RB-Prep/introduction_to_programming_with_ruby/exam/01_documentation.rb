# Problem 1: Use the each method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value
a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
a.each { |e| p e }

# Problem 2: Same as above, but only print out values greater than 5.
a.each { |e| p e if e > 5 }
new_array = a.each { |e| p e if e > 5 } # Array with values greater than 5
# Problem 3: using the same array from #2, use the select method to extract all odd numbers into a new array.
a.select { |e| e % 2 == 0 } # Original array: odd only
new_array.select { |e| e % 2 == 0 } # Array with values over 5: odd only

# Problem 4: Append 11 to the end of the original array. Prepend 0 to the beginning.

=begin
Different methods to append
1. a << 11
2. a.append(11)
3. a += [11] # Note: append needs to occur with the [] notation — otherwise it's invalid as it'd be an implicit conversion of Integer into Array
=end
a += [11] # Append
a.unshift(0) # Prepend

# Problem 5: Get rid of 11. And append a 3.

=begin
Different methods to delete 11
1. a.delete(11)
2. a.pop
3. a.delete_at(-1)
4. a = a.slice!(0, 11) # Note: this method prints the sliced elements but returns the elements that weren't included, in this case the last 11 we want to delete
5. a.slice!(11) # See explanation above on why this works
6. a -= [11] # Same concept as when adding elements to arrays — it needs to be enclosed in brackets
7. a.reject! { |e| e == 11 } # Note: bang is used to make the result the value of `a`
=end

a -= [11]
a += [3]

# Problem 6: Get rid of duplicates without specifically removing any one value.

a.uniq! # Bang to make a equal the result

# Problem 7: What's the major difference between an Array and a Hash?

# A hash has a key-value pair per element of the hash, whereas the array is structured via elements that can hold one object per index location

# Problem 8: Create a Hash, with one key-value pair, using both Ruby syntax styles.

hash = {key: "value"}
hash = {:key => "value"}

# Problem 9: Suppose you have a hash h = {a:1, b:2, c:3, d:4}

h = {a:1, b:2, c:3, d:4}
# 1. Get the value of key `:b`.

h[:b] # Note: as it's a symbol h["b"] will NOT work

# 2. Add to this hash the key:value pair `{e:5}`

h[:e] = 5

# 3. Remove all key:value pairs whose value is less than 3.5

h.select { |k, v| v > 3 } # Returns the correct result but does not save it to the variable h UNLESS a bang is used
h.reject { |k, v| v < 4 } # Note: bang is needed to save the result to the variable
h.each { |k, v| h.delete(k) if v < 4 } # Note: it saves to the result to the variable

# Problem 10: Can hash values be arrays? Can you have an array of hashes? (give examples)

# Yes 
h[:f] = [1,2,3]
h
# The inverse is also true: a hash can be an element of an array
a = [h] # Makes h a single element of the array
a += [2]

# Problem 11: Given the following data structures. Write a program that copies the information from the array into the empty hash that applies to the correct person

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

=begin
# Wrong answer: This rewrites the value pair each time

contacts["Joe Smith"] = {:email=>"joe@email.com"} # "Joe Smith"=>{:email=>"joe@email.com"}
contacts["Joe Smith"] = {:address=>"123 Main st."} # "Joe Smith"=>{:address=>"123 Main st."} -> OVERWROTE the above
contacts["Joe Smith"] = {:phone=>"555-123-4567"} # "Joe Smith"=>{:phone=>"555-123-4567"} -> OVERWROTE the above
contacts["Sally Johnson"] = {:email=>"sally@email.com"}
contacts["Sally Johnson"] = {:address=>"404 Not Found Dr."}
contacts["Sally Johnson"] = {:phone=>"123-234-3454"}
=end

contacts["Joe Smith"][:email] = "joe@email.com"
contacts["Joe Smith"][:address] = contact_data[0][1]
contacts["Joe Smith"][:phone] = contact_data[0][-1]
contacts["Sally Johnson"] = {:email=>"sally@email.com", :address=>"404 Not Found Dr.", :phone=>"123-234-3454"}

# Expected output:
#  {
#    "Joe Smith"=>{:email=>"joe@email.com", :address=>"123 Main st.", :phone=>"555-123-4567"},
#    "Sally Johnson"=>{:email=>"sally@email.com", :address=>"404 Not Found Dr.",  :phone=>"123-234-3454"}
#  }

# Problem 12: Using the hash you created from the previous exercise, demonstrate how you would access Joe's email and Sally's phone number?

p "Joe's email is #{contacts["Joe Smith"][:email]}"
p "Sally's phone number is #{contacts["Sally Johnson"][:phone]}"

# Problem 13: Use Ruby's Array method delete_if and String method start_with? to delete all of the words that begin with an "s" in the following array.
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
# Then recreate the arr and get rid of all of the words that start with "s" or starts with "w".

arr.delete_if { |e| e.start_with?("s") } # Mutates the array with the result
arr.unshift('snow') # Indifferent if single or double quotes are used
arr.insert(3, 'slippery', 'salted roads') # Insert can be used with multiple arguments to be inserted in the same spot by order
arr.delete_if { |e| e.start_with?("s") or e.start_with?("w")}

# Problem 14: Take the following array and turn it into a new array that consists of strings containing one word. (ex. ["white snow", etc...] → ["white", "snow", etc...]. Look into using Array's map and flatten methods, as well as String's split method.
a = ['white snow', 'winter wonderland', 'melting ice',
  'slippery sidewalk', 'salted roads', 'white trees']

a.map { |e| e.split }.flatten # Returns a result of arrays one level too deep and I apply flatten to that (by calling the method on the block itself)

# Problem 15: What will the following program output?

hash1 = {shoes: "nike", "hat" => "adidas", :hoodie => true}
hash2 = {"hat" => "adidas", :shoes => "nike", hoodie: true}

if hash1 == hash2
  puts "These hashes are the same!"
else
  puts "These hashes are not the same!"
end

# Prints "These hashes are the same!" because the keys are the same data types (string or symbol), just with different syntax or order (which doesn´t matter in hashes)

# Problem 16: Challenge: In exercise 11, we manually set the contacts hash values one by one. Now, programmatically loop or iterate over the contacts hash from exercise 11, and populate the associated data from the contact_data array. Hint: you will probably need to iterate over ([:email, :address, :phone]), and some helpful methods might be the Array shift and first methods.

# Note that this exercise is only concerned with dealing with 1 entry in the contacts hash, like this:

contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}
contacts.each |k, v| do
  split = k.split
  
  contact_data.each_with_index do |e, i|
    if i == 0
      contacts["Joe Smith"][:email] = e
    elsif i == 1
      contacts["Joe Smith"][:address] = e
    else
      contacts["Joe Smith"][:phone] = e
    end
  end
end
# As a bonus, see if you can figure out how to make it work with multiple entries in the contacts hash.