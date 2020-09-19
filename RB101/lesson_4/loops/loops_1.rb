# 1. Modify the code so the loop stops after the first iteration.

loop do
  puts "Just keep printing..."
  break # break ends the loop.
end

# 2. Modify the code so each loop stops after the first iteration.

loop do
  puts 'This is the outer loop.'

  loop do
    puts 'This is the inner loop.'
    break
  end

  break
end

puts 'This is outside all loops.'

# 3. Modify the following loop so it iterates 5 times instead of just once.

iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1
  break if iterations = 5
end

# 4. Modify the code below so the loop stops iterating when the user inputs 'yes'.

loop do
  puts 'Should I stop looping?'
  answer = gets.chomp
  break if answer == "yes"

  puts "Incorrect input. Please answer 'yes' to stop".
end

# 5. Modify the code below so "Hello!" is printed 5 times.

say_hello = true
count = 0
while say_hello
  puts 'Hello!'
  count += 1
  say_hello = false if count >= 5
end

# 6. Using a while loop, print 5 random numbers between 0 and 99.

numbers = []

while numbers.length <= 5
  puts (number = rand(0..99))
  numbers << number
end

puts numbers

# 7. The following code outputs a countdown from 10 to 1. Modify the code so that it counts from 1 to 10 instead.

count = 1

while count <= 10
  puts count
  count += 1
end

# 8. Given the array of several numbers below, use an until loop to print each number.

numbers = [7, 9, 13, 25, 18]

until numbers.length == 0
  puts (numbers.shift)
end

# 9. Modify the code so that it only outputs i if i is an odd number.

for i in 1..100
  puts i if i % 2 == 1 # i.odd? is better!
end

# 10. Use a for loop to greet each friend individually.

friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends
  puts "Hello, #{friend}!"
end