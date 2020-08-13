# 1. Write a program that asks the user to type in their name and then prints out a greeting message with their name included.

puts "What is your first name?"
first_name = gets.chomp
puts "What is your last name?"
last_name = gets.chomp
name = first_name + " " + last_name
puts "Hello, #{name}!"

# 2. Ask a user how old they are and then tells them how old they will be in 10, 20, 30 and 40 years.

puts "What's your age?"
age = gets.chomp.to_i
puts "In 10 years you'll be #{age+10}"
puts "In 20 years you'll be #{age+20}"
puts "In 30 years you'll be #{age+30}"
puts "In 40 years you'll be #{age+40}"

# 3. Print the name of the user 10 times. You must do this without explicitly writing the puts method 10 times in a row

puts "===\nFirst trial\n==="
10.times { puts "#{name}"}
puts "===\nSecond trial\n==="
(0...10).each { puts "#{name}" }

# 4. What's the result of the programs below?

x = 0 
3.times do
  x += 1 # Variables defined in the outer scope are available in the inner scope
end
puts x # print 3, return 0

y = 0
3.times do
  y += 1
  x = y
end
puts x # error: a variable defined in the inner scope is NOT accessible in the outer scope