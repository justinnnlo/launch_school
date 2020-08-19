# 1. Write an if statement that prints "The sun is so bright!" if sun equals 'visible'.


sun = ['visible', 'hidden'].sample

puts "The sun is so bright!" if sun == "visible"



# 2. Write an unless statement that prints "The clouds are blocking the sun!" unless sun equals 'visible'.

sun = ['visible', 'hidden'].sample

puts "The clouds are blocking the sun!" unless sun == "visible"



# 3. Write an if statement that prints "The sun is so bright!" if sun equals visible. Also, write an unless statement that prints "The clouds are blocking the sun!" unless sun equals visible.

puts "The sun is so bright!" if sun == "visible"
puts "The clouds are blocking the sun!" unless sun == "visible"



# 4. Write a ternary operator that prints "I'm true!" if boolean equals true and prints "I'm false!" if boolean equals false.

# Gist: ternary operators with complex arguments wrapped in parentheses

boolean = [true, false].sample

boolean ? (puts "I'm true!") : (puts "I'm false!")



# 5. What will the following code print? Why?

number = 7

if number # executes as true given the boolean of an integer is true - in fact, any expression but false and nil evaluate to true in a condition.
  puts "My favorite number is #{number}." # prints this
else
  puts "I don't have a favorite number."
end



# 6. Write a case statement that prints "Go!" if stoplight equals 'green', "Slow down!" if stoplight equals 'yellow', and "Stop!" if stoplight equals 'red'.

# Gist: case statements

stoplight = ['green', 'yellow', 'red'].sample

case stoplight
when "green"
  puts "Go!"
when "yellow"
  puts "Slow down!"
when "red"
  puts "Stop!"
end

# Original MISTAKE: using if instead of when



# 7. Convert the above case statement to an if statement.

# Gist: compare case and if statements - the former is cleaner to read because we reference the variable only once (in "case")
# Takeaway: use case for mulriple comparisons of a single variable

if stoplight == "green"
  puts "Go!"
elsif stoplight == "yellow"
  puts "Slow down!"
else
  puts "Stop!"
end



# 8. Write an if statement that returns "Be productive!" if status equals 'awake' and returns "Go to sleep!" otherwise. Then, assign the return value of the if statement to a variable and print that variable.

# Gist: binding variables with if statements
# When does it make sense to structure the code like this?

status = ['awake', 'tired'].sample

status_result = if status == "awake"
  "Be productive!"
else
  "Go to sleep!"
end

puts status_result



# 9. Currently, "5 is a cool number!" is being printed every time the program is run. Fix the code so that "Other numbers are cool too!" gets a chance to be executed.

number = rand(10)

if number == 5 # changed a reassignment (number = 5) to a comparison (==) operation
  puts '5 is a cool number!'
else
  puts 'Other numbers are cool too!'
end



# 10. Reformat the following case statement (in #7) so that it only takes up 5 lines.

# Gist: using the documentation to find and use the then reserved word for 1-line conditionals, formatting code for readability

stoplight = ['green', 'yellow', 'red'].sample

case stoplight

#Either then or semicolon after when, except for "else"

  when 'green';      puts 'Go!'
  when 'yellow' then puts 'Slow down!'
  else               puts 'Stop!'
end