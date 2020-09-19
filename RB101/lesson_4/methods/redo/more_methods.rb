# 1. Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
hash = {}

flintstones.each_with_index { |ele, index| hash[ele] = index }

count = 0

flintstones.each_with_object(Hash.new {0}) do |ele, object|
  object[ele] += count
  count += 1
end

# 2. Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.sum

ages.values.inject (&:+)
# ages.inject (&:+) => Doesn't work because it iterates through each key and value!

sum = 0
ages.each { |_, value| sum += value } # "_" means the argument isn't used

# 3. remove people with age 100 and greater.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.reject! { |_, value| value > 99 }  # Mutates hash
ages.select! { |_, value| value < 100 } # Mutates hash
ages.keep_if { |_, value| value < 100 } # Mutates hash

# 4. Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.min # 10

# Further exploration: key-value pair of youngest person

ages.min        # ["Eddie", 10]

# 5. Find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

results = []
flintstones.each_with_index { |ele, index| results << index if ele[0,2] == "Be" }
results[0]

# Best result: flintstones.index { |name| name[0, 2] == "Be" }



# 6. Amend this array so that the names are all shortened to just the first three characters:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! { |ele| ele[0,3] }

# 7. Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"
hash = Hash.new {0}

statement.split.join.each_char { |ele| hash[ele] += 1 }

# 8. What happens when we modify an array while we are iterating over it?

# Answer: it might modify what element is evaluated in the iterations

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number          #     1, 3
  numbers.shift(1)  #     1, 2
end                 # => [3, 4]

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number        #     1, 2
  numbers.pop(1)  #     4, 3
end               # => [1, 2]

# 9. Write your own version of the rails titleize implementation.

def titalize(string)
  string.split.map { |word| word.capitalize }.join(" ")
end

# 10. Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior).

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def age_group(hash)
  hash.each do |key, value|
    case value["age"]
    when 0..17
      hash[key]["age_group"] = "kid"
    when 18..64
      hash[key]["age_group"] = "adult"
    else
      hash[key]["age_group"] = "senior"
    end
  end
end