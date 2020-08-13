p "What is your first name?" # Print a message before the gets — otherwise the user will be asked to input without context
first_name = gets.chomp
p "What is your last name?"
last_name = gets.chomp
p "Hello, #{first_name} #{last_name}!"
puts ""
p "What is your age, #{first_name}?"
age = gets.chomp.to_i # Needs to be converted to integer as gets treats the input as a string
puts ""
age+=10
p "In 10 years you will be: #{age} years old"
age+=10
p "In 20 years you will be: #{age} years old"
age+=10
p "In 30 years you will be: #{age} years old"
age+=10
p "In 40 years you will be: #{age} years old"
puts ""
10.times { puts first_name }

# Problem 5: what does each program print?

# Block 1
x = 0
3.times do
  x += 1
end
puts x

# Block 2: error because x is inside the scope of the block (unless block 1 is run before, which would return 3 as above) 
y = 0
3.times do
  y += 1
  x = y
end
puts x