# 1. Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
hash = {}

flintstones.each_with_index do |name, index|
  hash[name] = index
end



# 2. Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.sum

ages.map { |key, value| value }.sum

ages.map do |key, value|
  value
end.sum

ages.each_with_object([]) do |pairs, result|
  result << pairs.last
end.sum

total_years = 0
ages.each { |key, value| total_years += value }

ages.values.inject(&:+) # || ages.values.inject(:+)



# 3. remove people with age 100 and greater.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.select! { |_, value| value < 100 } # Use "_" when you arent using the argument

# Alternative: Hash#keep_if
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.keep_if { |_, value| value < 100 }



# 4. Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.min # => 10



# 5. Find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles Beatty)

# My solution
indices = []

flintstones.each_with_index {|name, index| indices << index if name[0, 2] == "Be" }
indices[0]

# Optimal solution
flintstones.index { |name| name[0,2] == "Be" }



# 6. Amend this array so that the names are all shortened to just the first three characters:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! { |word| word[0, 3] }



# 7. Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

hash = Hash.new {0}

statement.split.join.each_char { |char| hash[char] += 1 } # split.join to remove the " "



# 8. What would be the output of these code blocks?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number # 1, 3
  numbers.shift(1) # .shift deletes index 0 with 1, index 1 with 2, etc
  p numbers
end # [3, 4]

# What happened here?
# shift deletes the first element of the array, but the iteration continues based on the index value
=begin
Iteration 1
Print: 1
Shift: 1
Object: [2, 3, 4]
===
Iteration 2
Print: 3
Shift: 2
Object: [3, 4]
===
No iteration 3 because index 2 doesn't exist anymore!
Return: [3, 4]
=end

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number # 1, 2
  numbers.pop(1) # 4, 3
end

# Prints: 1, 2
# Pops: 4, 3
# Returns: [1, 2]



# 9. Write your own version of the rails titleize implementation.

def titalize(string)
  string.split.map { |word| word[0].upcase + word[1,100] }.join(" ")
end

# optimal
def titalize(string)
  string.split.map { |word| word.capitalize }.join(" ")
end



# 10. Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). A kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  if munsters[key]["age"] > 64
    munsters[key]["age_group"] = "senior"
  elsif munsters[key]["age"] < 17
    munsters[key]["age_group"] = "kid"
  else
    munsters[key]["age_group"] = "adult"
  end
end

# Improved code syntax: value["age"] > munsters[key]["age"]

munsters.each do |key, value|
  if value["age"] > 64
    value["age_group"] = "senior"
  elsif value["age"] < 17
    value["age_group"] = "kid"
  else
    value["age_group"] = "adult"
  end
end

# Improved code structure: using case
# Key note: case statements don't work with comparisons

munsters.each do |key, value|
  case value["age"]
  when 0..17
    value["age_group"] = "kid"
  when 18..64
    value["age_group"] = "adult"
  else
    value["age_group"] = "senior"
  end
end