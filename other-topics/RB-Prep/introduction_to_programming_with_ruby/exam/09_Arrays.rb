
# 1. Select 'fish' from pets, assign the return value to a variable named my_pet, then print the value of my_pet.

# Gist: array indexing, binding a variable with a return from an array

pets = ['cat', 'dog', 'fish', 'lizard']

my_pet = pets[2]

puts "I have a pet #{my_pet}"



# 2. Write some code that selects 'fish' and 'lizard' form the pets array - select the two items at the same time. Assign the return value to a variable named my_pets, the print the contents of my_pets as a single string, e.g.:

# Gist: array slicing and string interpolation with array elements

my_pets = pets[2,2]
my_pets = pets[2..3] # Alternative using range

puts "I have a pet #{my_pets[0]} and a pet #{my_pets[1]}!"



# 3. Remove 'lizard' from my_pets then print the value of my_pets.

# Gist: mutate array

pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]
my_pets.pop # OR my_pets[-1] = ""

puts "I have a pet #{my_pets}"

# Alternatives

=begin
my_pets[-1] = "" -> WRONG!!!: mutates element to "" instead of deleting it
my_pets.delete_at(-1)
=end



# 4. Using the code below, select 'dog' from pets, add the return value to my_pets, then print the value of my_pets.

pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]
my_pets.pop

my_pets << pets[1]

puts "I have a pet #{my_pets[0]} and a pet #{my_pets[1]}!"

=begin
Alternatives to the shovel operator

my_pets[1] = pets[1] -> assignin a value to an index
my_pets.push(pets[1]) -> pushing a value to the array
=end



# 5. Use Array#each to iterate over colors and print each element.

# Gist: array iteration

colors = ['red', 'yellow', 'purple', 'green']

# Method 1: each iteration

colors.each { |color| puts "I'm the color #{color}!" }

# Method 2: for loop iteration

for color in colors
  puts "I'm the color #{color}" # Using the loop's local variable color in the for loop
end



# 6. Use Array#map to iterate over numbers and return a new array with each number doubled. Assign the returned array to a variable named doubled_numbers and print its value using #p.

# Gist: returning a new array with map and printing it with p (prints the whole rather than the parts by sequence)

numbers = [1, 2, 3, 4, 5]

p doubled_numbers = numbers.map { |number| number * 2 }


# 7. Use Array#select to iterate over numbers and return a new array that contains only numbers divisible by three. Assign the returned array to a variable named divisible_by_three and print its value using #p.

# Gist: using the select method to create a new array

numbers = [5, 9, 21, 26, 39]

p divisible_by_three = numbers.select { |number| number % 3 == 0 }



# 8. Group each name with the number following it by placing the pair in their own array. Then create a nested array containing all three groups. What does this look like?

# Gist: Creating nested arrays

original_array = ['Dave', 7, 'Miranda', 3, 'Jason', 11]

[['Dave', 7], ['Miranda', 3], ['Jason', 11]]

original_array.each {
  


# 9. Flatten and print this array. That is, the printed result should not have any subarrays, but should have all of the original strings and numbers from the original array:

# Gist: how to flatten nested arrays

favorites = [['Dave', 7], ['Miranda', 3], ['Jason', 11]]

p favorites.flatten



# 10. Compare array1 and array2 and print true or false based on whether they match.

# Gist: comparing arrays

array1 = [1, 5, 9]
array2 = [1, 9, 5]

puts array1 == array2 # false, because order matters in arrays