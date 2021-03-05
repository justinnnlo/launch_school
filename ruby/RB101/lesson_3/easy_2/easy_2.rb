# 1. See if "Spot" is present.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.key?("Spot")
p ages.any? { |key, value| key == "Spot" }
p ages.none? { |key, value| key != "Spot" }

# Methods I didn't think of
p ages.include?("Spot")
p ages.member?("Spot")

# 2. Convert the string in the following ways (code will be executed on original munsters_description above):

munsters_description = "The Munsters are creepy in a good way."

munsters_description.swapcase == "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
munsters_description.capitalize == "The munsters are creepy in a good way."
munsters_description.downcase == "the munsters are creepy in a good way."
munsters_description.upcase == "THE MUNSTERS ARE CREEPY IN A GOOD WAY."

# 3. Add to the existing hash (assumption: hash mutation)

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages.merge(additional_ages)

# 4. Does "Dino" appear in the string?

advice = "Few things in life are as important as house training your pet dinosaur."

advice.include?("Dino")
advice.match?("Dino")

# 5. Easier way to write this array?

flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstone = %w(Fred Barney Wilma Betty BamBam Pebbles) # Spaces between %w and parentheses kills it

# 6. How can we add "Dino"?

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles) << "Dino"

# 7. Add Dino and Hoppy simultaneously

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino" << "Hoppy"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push("Dino", "Hoppy")

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.concat(["Dino"], ["Hoppy"])
flintstones.concat(%w(Dino Hoppy)) # unlike `push` and `<<`, `concat` doesn't implicitly convert string to array

# 8. Remove everything starting from "house"

advice = "Few things in life are as important as house training your pet dinosaur."

array = advice.split
advice = array[0...array.index("house")].join

advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice!(advice.index("house")..advice.length)

# 9. Count the lower case "t" chars

statement = "The Flintstones Rock!"

statement.count("t")

# 10. Center with spaces on 40 chars

title = "Flintstone Family Members"
title.center(40)