
# 1. Create a hash that contains the following data and assign it to a variable named car.

# Gist: creating hashes and formatting them for easy reading

car = {
  type:    "sedan",
  color:   "blue",
  mileage: 80_000 }

# Why use symbols over strings? They use less memory and are faster



# 2. Using the code below, add the key :year and the value 2003 to car.

# Gist: adding new key/value pairs

car[:year] = 2003
p car



# 3. Using the following code, delete the key :mileage and its associated value from car.

# Gist: Deleting key/value pairs

car = {
  type:    'sedan',
  color:   'blue',
  mileage: 80_000,
  year:    2003
}

car.delete(:mileage) # returns the mutated string
p car



# 4. Using the following code, select the value 'blue' from car and print it with #puts.

# Gist: accessing keys and value
puts car[:color]



# 5. Use Hash#each to iterate over numbers and print each element's key/value pair.

# Gist: hash iteration with each

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

numbers.each { |key, value| puts "A #{key} number is #{value}." }



# 6. Use Enumerable#map to iterate over numbers and return an array containing each number divided by 2. Assign the returned array to a variable named half_numbers and print its value using #p.

# Gist: Using map with hashes and assigning the returned value to a variable

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

p half_numbers = numbers.map { |key, value| value/2 }



# 7. Use Hash#select to iterate over numbers and return a hash containing only key-value pairs where the value is less than 25. Assign the returned hash to a variable named low_numbers and print its value using #p.

# Gist: using Hash#select

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

p low_numbers = numbers.select { |key, value| value < 25 } # Select returns a hash!



# 8. In the following code, numbers isn't mutated because #select isn't a destructive method. However, there is a destructive version of #select named #select!. Modify the code to use #select! instead of #select.

# Gist: modifying select to have the method mutate the caller (numbers)

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

low_numbers = numbers.select! do |key, value|
                 value < 25
               end

p low_numbers
p numbers



# 9. Create a nested hash using the following data.

# Gist: nesting hashes

parent = {
  Car:    {type:"sedan", color:"blue", year:2003},
  Truck:  {type:"sedan", color:"red", year:1998}
}



# 10. Rewrite car as a nested array containing the same key-value pairs.

# Gist: comparing arrays with hashes for an object with value pairs

car = {
  type:  'sedan',
  color: 'blue',
  year:  2003
}

new_car = [[:type, "sedan"], [:color, "blue"], [:year, 2003]]