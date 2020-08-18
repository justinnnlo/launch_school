
# 1. Write a program that asks the user to type something in, after which your program should simply display what was entered.

# Gist: Basics of user input and how to output it

puts ">> Type anything you want:" # Use >> to distinguish prompts from other types of text
input = gets.chomp
puts input



# 2. Write a program that asks the user for their age in years, and then converts that age to months.

# Gist: how to convert inputs to other data types and manipulate them

puts ">> What is your age in years?"
age = gets.chomp.to_i # 0 if the input is non-numeric because strings are converted to 0
puts "You are #{age * 12} months old!"



# 3. Write a program that asks the user whether they want the program to print "something", then print it if the user enters y. Otherwise, print nothing.

# Gist: control flow with user input

puts ">> Do you want me to print something? (y/n)"
answer = gets.chomp
puts "something" if answer.downcase == "y" # answer.downcase to ensure it's processed regardless of case
# All inputs except "y" and "Y" imply a negative reply



# 4. Modify your program so it prints an error message for any inputs that aren't y or n, and then asks you to try again. Keep asking for a response until you receive a valid y or n response. In addition, your program should allow both Y and N (uppercase) responses; case sensitive input is generally a poor user interface choice. Whenever possible, accept both uppercase and lowercase inputs.

# Gist: how to raise errors and make loops with exceptions

# Method 1: optimized do loop

answer = nil # assigned outside the loop so that it's accessible outside
loop do
  puts ">> Do you want me to print something? (y/n)"
  answer = gets.chomp.downcase
  
  # Apply downcase on the variable assignment
  break if ["y", "n"].include?(answer)
  
  # Break if answer is found within the set of valid replies
  
  puts ">> Invalid input! Use 'y' or 'n'"
end

puts "something" if answer == "y"



# Method 2: my version with do loop

choice = nil # nil allows the variable to be inputted anything
loop do
  puts ">> Do you want me to print something? (y/n)"
  answer = gets.chomp
  choice = true if answer.downcase == "y" or answer.downcase == "n"
  
  # Unnecessary to have both answer AND choice - see above where include for the boolean
  puts "something" if answer.downcase == "y"
  
  # downcase should be applied at the variable assignment
  break if choice == true # if still nil the loop continues
  puts ">> Invalid input! Use 'y' or 'n'" # AFter the break: only prints if not broken
end
  
  
  
# Method 3: my original take with unless and a while loop

puts ">> Do you want me to print something? (y/n)"
answer = gets.chomp
unless answer.downcase == "y" or answer.downcase == "n"
  while true
    puts ">> Invalid input! Please enter y or n"
    answer = gets.chomp
    break if answer.downcase == "y" or answer.downcase == "n"
  end
end
puts "something" if answer.downcase == "y"



# 5. Write a program that prints 'Launch School is the best!' repeatedly until a certain number of lines have been printed. The program should obtain the number of lines from the user, and should insist that at least 3 lines are printed.

# Method 1: slightly more efficient in terms of lines of code but a bit less readable

loop do
  puts ">> How many output lines do you want? Enter a number >= 3:"
  number = gets.chomp.to_i
  
  if number >= 3
    for iteration in (0...number)
      puts "Launch School is the best!"
    end
    break
  end
  puts ">> That's not enough lines."
end



# Method 2: more readable variation

number_of_lines = 0
loop do
  puts ">> How many output lines do you want? Enter a number >= 3:"
  number_of_lines = gets.chomp.to_i
  break if number_of_lines >= 3
  puts ">> That's not enough lines."
end

while number_of_lines > 0
  puts "Launch School is the best!"
  number_of_lines -= 1
end

=begin
TAKEAWAYS

1. More descriptive variable names
2. Breaking the program in 2 and by the order of their sequence - it's much easier to read than a single loop containing the whole process
3. Using a single variable: define in outer scope and then use as counter by reassigning the variable with each loop
=end



# 6.Write a program that displays a welcome message, but only after the user enters the correct password, where the password is a string that is defined as a constant in your program. Keep asking for the password until the user enters the correct password.

PASSWORD = "hello"

loop do
  puts ">> Please enter your password:"
  password_trial = gets.chomp

  # Make the variable DESCRIBE what it does (password trial) rather than what it is (input)
  break if input == PASSWORD
  puts ">> Invalid password!"
end

puts "Welcome!"


  
# 7. You should modify the program so it also requires a user name. The program should solicit both the user name and the password, then validate both, and issue a generic error message if one or both are incorrect; the error message should not tell the user which item is incorrect.

USERNAME = "14jdelap"
PASSWORD = "hello"

loop do
  puts ">> Please enter your username:"
  username_trial = gets.chomp
  puts ">> Please enter your password:"
  password_trial = gets.chomp
  
  break if username_trial == USERNAME and password_trial == PASSWORD
  puts ">> Authentication failure!"
end

puts "Welcome!"



# 8. Write a program that obtains two Integers from the user, then prints the results of dividing the first by the second. The second number must not be 0, and both numbers should be validated. This method returns true if the input string can be converted to an Integer and back to a string without loss of information, false otherwise. It's not a perfect solution in that some inputs that are otherwise valid (such as 003) will fail, but it is sufficient for this exercise.

def valid_number?(number_string)
  number_string.to_i.to_s == number_string
end

numerator = nil
denominator = nil

loop do
  puts ">> Please enter the numerator:"
  numerator = gets.chomp
  
  break if valid_number?(numerator)
  puts ">> Invalid input. Only integers are allowed."
end

loop do
  puts ">> Please enter the denominator:"
  denominator = gets.chomp
  
  if denominator == "0"
    puts '>> Invalid input. A denominator of 0 is not allowed.'
  else
    break if valid_number?(denominator)
    puts ">> Invalid input. Only integers are allowed."
  end
end

result = (numerator.to_i/denominator.to_i)

# result needed because string interpolation cannot handle operations

puts "#{numerator} / #{denominator} is #{result}"



# 9. Modify the program so it repeats itself after each input/print iteration, asking for a new number each time through. The program should keep running until the user enters q or Q.

# Initial trial - with significant problems

loop do
  number_of_lines = nil
  loop do
    puts ">> How many output lines do you want? Enter a number >= 3:"
    number_of_lines = gets.chomp.to_i
    
    # BIG problem: ANY string converted to "i" results in a value of 0
  
    break if number_of_lines >= 3
    puts ">> That's not enough lines."
  end
  
  while number_of_lines > 0
    puts "Launch School is the best!"
    number_of_lines -= 1
  end
  
  break if number_of_lines.class == "String".class and number_of_lines.downcase == "q" # For strigns this says: if 0.class == "string".class and 0.downcase == "q"
  
end



loop do
  original_input = nil
  number_of_lines = nil
  
  # Variables in the outer scope so they can be applied anywhere within the loop
  
  loop do
    puts ">> How many output lines do you want? Enter a number >= 3:"
    original_input = gets.chomp # Store original input for string comparison
    number_of_lines = temp.to_i # COnvert a version to integer for integer comparison
  
    break if number_of_lines >= 3 or original_input.downcase == "q"
    puts ">> That's not enough lines."
  end
  
  while number_of_lines > 0
    puts "Launch School is the best!"
    number_of_lines -= 1
  end
  
  break if (original_input.class == "g".class) and (original_input.downcase == "q")
end



# 10. Write a program that requests two integers from the user, adds them together, and then displays the result. Furthermore, insist that one of the integers be positive, and one negative; however, the order in which the two integers are entered does not matter. Do not check for the positive/negative requirement until both integers are entered, and start over if the requirement is not met.

# My original version: 3 loops and an if statement with control flow (break if successful).

loop do
  number_1 = nil
  number_2 = nil
  
  loop do
    puts ">> Please enter a positive or negative integer:"
    number_1 = gets.chomp.to_i
    break if number_1 != 0
    puts ">> Invalid input. Only non-zero integers are allowed."
  end
  
  loop do
    puts ">> Please enter a positive or negative integer:"
    number_2 = gets.chomp.to_i
    break if number_2 != 0
    puts ">> Invalid input. Only non-zero integers are allowed."
  end
  
  if (number_1 < 0 and number_2 > 0) or (number_1 > 0 and number_2 < 0)
    puts "#{number_1} + #{number_2} = #{number_1+number_2}"
    break
  end

  puts ">> Sorry. One integer must be positive, one must be negative."
  puts ">> Please start over.\n\n"
end

# Optimized version: refactor the code to get each number into a method, and call that method for each number; not necessary to define the 2 variables at the top

loop do

  def get_number
    loop do
      puts ">> Please enter a positive or negative integer:"
      number = gets.chomp.to_i
      return number if number != 0
      puts ">> Invalid input. Only non-zero integers are allowed."
    end
  end
  
  number_1 = get_number
  number_2 = get_number

  if (number_1 < 0 and number_2 > 0) or (number_1 > 0 and number_2 < 0)
    puts "#{number_1} + #{number_2} = #{number_1+number_2}"
    break
  end

  puts ">> Sorry. One integer must be positive, one must be negative."
  puts ">> Please start over.\n\n"
end