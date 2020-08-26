
# 1, Modify the code so the loop stops after the first iteration.

# Gist: how to use control flow to stop a loop execution

loop do
  puts 'Just keep printing...'
  break # Add the break to stop the execution of the loop
end



# 2. Modify the code so each loop stops after the first iteration.

# Gist: controlling the execution of nested loops
# Suggestion: focus on one loop at a time - break down the problem into smaller pieces

loop do
  puts 'This is the outer loop.'

  loop do
    puts 'This is the inner loop.'
    break # break after the inner loop's first iteration
  end
      # newline to make the code more readable
  break # break after the outer loop's first iteration
end

puts 'This is outside all loops.'



# 3. Modify the following loop so it iterates 5 times instead of just once.

# Gist: control flow with do/while loops

iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1 # Originally missed this line
  break if iterations == 5
  
  # If the break statement is moved up one line so it runs before iterations is incremented, what would need to be changed?
  # Answer: break if iterations == 4
end

# 4. Modify the code below so the loop stops iterating when the user inputs 'yes'.

loop do
  puts 'Should I stop looping?'
  answer = gets.chomp
  break if answer == "yes" # Add this line that would be evaluated with each loop, as the user inputs a new answer each time
end



# 5. Modify the code below so "Hello!" is printed 5 times.

# Gist: control flow in while loops using booleans

say_hello = true
count = 0

while say_hello
  puts 'Hello!'
  count += 1
  say_hello = false if count == 5
end



# 6. Using a while loop, print 5 random numbers between 0 and 99.

# Gist: using an object property as a counter, using random

count = 0

while count != 5
  puts rand(0..99)
  count += 1
end

# Aternative using an array and its length as a counter

array = []

while array.length != 5
  array << rand(0..99)
end

puts array



# 7. Modify the code so that it counts from 1 to 10 instead.

# Gist: using until loops

count = 1

until count > 10 # Originally put until count == 10, which would've printed until 9
  puts count
  count += 1
end



# 8.Given the array of several numbers below, use an until loop to print each number.

# Gist: until loops arrays, and iteration

# Method 1: using count to iterate and print each element using index

numbers = [7, 9, 13, 25, 18]

count = 0

until count == numbers.size # Changed from count == 5, which was only specific to this example
  puts numbers[count]
  count += 1
end

# Method 2: using shift to mutate the object and print each until the array is empty

until numbers.length == 0
  puts numbers[0]
  numbers.shift # Shift removes the element in index 0
end

puts numbers # Returns nil, prints nothing



# 8. Modify the code so that it only outputs i if i is an odd number

# Gist: for loops and basic maths operations

for i in 1..100
  puts i if i.odd?
  # puts i if i % 2 == 1 -> an alternative
  
end



# 10. Given the following array of names, use a for loop to greet each friend individually.

# Gist: Array iteration in for loops, string interpolation, and variable naming

friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends # Changed from "for i..." to have descriptive naming of the placeholder variable
  puts "Hello, #{i}!"
end



# PART 2

# 11. Write a loop that prints numbers 1-5 and whether the number is even or odd. Use the code below to get started.

# Gist: printing with a while/do loop, ternary operator nuances

count = 1

loop do
  count.even? ? (puts "#{count} is even!") : (puts "#{count} is odd!") # puts needs to go within a parentheses because this is a complex ternary operation
  
  # One of the main virtues of a ternary operation is that it's easy to read - beware when it isn't!
  
  count += 1
  break if count > 5
end

# 12. Modify the following code so that the loop stops if number is equal to or between 0 and 10.

# Gist: working with ranges of numbers to return a boolean

# Method 1 and 2: EASY

loop do
  number = rand(100)
  puts number
  break if number.between?(0,10) # Between returns a boolean if a number is between the range
end

loop do
  number = rand(100)
  puts number
  break if [0,1,2,3,4,5,6,7,8,9,10].include? number # Between returns a boolean if a number is between the range
end


# Method 3: Moderate difficulty


loop do
  number = rand(100)
  puts number
  break if (0..10).any? { |num| num == number }
end

# Method 4: FAILED

loop do
  number = rand(100)
  puts number
  for num in (0..10)
    break if num == number
    
    # break only breaks the for loop, not the do loop
  end
end



# 13. Using an if/else statement, run a loop that prints "The loop was processed!" one time if process_the_loop equals true. Print "The loop wasn't processed!" if process_the_loop equals false.

# Gist: binding an object with a method to a variable and loops within conditionals (in this case, do within an if statement)

process_the_loop = [true, false].sample

if process_the_loop
  loop do
    puts "The loop was processed!"
    
    # Originally misread the question and didn't include the loop
    break
  end
else
  puts "The loop wasn't processed!"
end



# 14. Modify the code so "That's correct!" is printed and the loop stops when the user's answer equals 4. Print "Wrong answer. Try again!" if the user's answer doesn't equal 4.

# Gist: breaking within an if statement within a loop, working with user input

loop do
  puts 'What does 2 + 2 equal?'
  answer = gets.chomp.to_i
      # New line between chunks of code
  if answer == 2
    puts "That's correct!"
    break
    
    # break works because it breaks the do loop because the if statement is NOT a loop
  else
    "Wrong answer, try again!"
  end
end



# 15. Modify the code below so that the user's input gets added to the numbers array. Stop the loop when the array contains 5 numbers.

# Gist: inserting elements within an array, working with user input

# Method 1 (array mutation): using the shovel operator

numbers = []

loop do
  puts 'Enter any number:'
  input = gets.chomp.to_i
  numbers << input
  break if numbers.length == 5
end
puts numbers

# Method 2 (variable reassignment x 5): using the += method to create a new object with each reassignment, each lengthening the array

numbers = []

loop do
  puts 'Enter any number:'
  input = gets.chomp.to_i
  numbers += [input]
  break if numbers.length == 5
end
puts numbers



# 16. Given the array below, use loop to remove and print each name. Stop the loop once names doesn't contain any more elements.

# Gist: mutating arrays, printing the values of array elements, do/while loops

names = ['Sally', 'Joe', 'Lisa', 'Henry']

loop do
  puts names.shift
  break if names.length == 0 # OR break if names.empty?
end



# 17. Modify the block so that it prints the current number and stops iterating when the current number equals 2.

# Gist: times method, blocks, conditional breaks

5.times do |index| # times counts from 0...5 but then RETURNS 5 unless break is applied and returns something else
  puts index
  break if index == 2
end

# 18. Using next, modify the code below so that it only prints even numbers.

# Gist: using next for control flow

number = 0

until number == 10
  number +=
  next if number.odd? # Skips remaining code and goes to next iteration
  
  #Originally misread the question and used an if statement
  puts number
end



# 19. Use next to modify the code so that the loop iterates until either number_a or number_b equals 5. Print "5 was reached!" before breaking out of the loop.

# Gist: break with an or statement, next and break to control the flow of the program, rand with 1 number (2, ie 0 or 1), random addition

number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)

  next if !(number_a >= 5) or !(number_b >= 5)
  
  # Misread the original and did not include next or the puts
  puts "5 was reached!"
  break
end



# 20. Given the code below, use a while loop to print "Hello!" twice.

# Gist: while loops within methods, passing arguments to methods

def greeting(num=1) # default argument to ensure it works if an argument isn't passed
  count = 0
  while count != num
    puts 'Hello!'
    count += 1
  end
end

number_of_greetings = 2

greeting(number_of_greetings)