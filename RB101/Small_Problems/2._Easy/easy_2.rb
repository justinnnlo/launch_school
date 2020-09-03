# 1. Build a program that randomly generates and prints Teddy's age.
# To get the age, you should generate a random number between 20 and 200.

def teddy_age?
  puts "What's your name?"
  name = gets.chomp
  return puts "#{name} is #{rand(20..200)} years old!" if !name.empty?
  puts "Teddy is #{rand(20..200)} years old!"
end

teddy_age?

# 2. Build a program that asks a user for the length and width of a room in
# meters and then displays the area of the room in both square meters and square feet.
SQMETER_TO_SQ_FEET = 10.7639

def room_size
  puts "Enter the length of the room in meters:"
  meter_length = gets.chomp.to_f
  
  puts "Enter the width of the room in meters:"
  meter_width = gets.chomp.to_f
  
  square_meters = (meter_length * meter_width).round(2)
  square_feet = (square_meters * SQMETER_TO_SQ_FEET).round(2)
  puts "The area of the room is #{square_meters} square meters (#{square_feet} square feet)."
end

room_size

# 3. The program should prompt for a bill amount and a tip rate.
# The program must compute the tip and then display both the tip and the total amount of the bill.

def calculate_tip
  puts "What is the bill?"
  bill = gets.chomp.to_f

  puts "What's the tip percentage in decimals (e.g. 15% == 0.15?"
  tip_percentage = gets.chomp.to_f
  tip = (bill * tip_percentage)
  total = bill + tip

  puts "The tip is $%0.2f." % [tip]
  puts "The total is $%0.2f." % [total]
end

calculate_tip

# 4. Build a program that displays when the user will retire and how 
# many years she has to work till retirement.

NUMBERS = [*"0".."9"]

def current_age
  loop do
    puts "What is your age?"
    age = gets.chomp
    return age.to_i if age.chars.all? { |num| NUMBERS.include?(num) }
    puts "You inserted an invalid number. Please enter your age again."
  end
end

def age_retire
  loop do
    puts "At what age would you like to retire?"
    age = gets.chomp
    return age.to_i if age.chars.all? { |num| NUMBERS.include?(num) }
    puts "You inserted an invalid number. Please enter your age again."
  end
end

age = current_age
retire = age_retire
years_to_retire = retire - age
puts "It's #{Time.new.year}. You'll retire in the year #{Time.new.year + years_to_retire}."
puts "You have #{years_to_retire} more years to go!"


# 5. Write a program that will ask for user's name. The program will then greet the user. 
# If the user writes "name!" then the computer yells back to the user.

ALPHABET = [*"a".."z", *"A".."Z", "!"]

def ask_name
  loop do
    puts "What is your name?"
    name = gets.chomp
    return name if name.to_s.chars.all? { |char| ALPHABET.include?(char) }
    puts "Your name has a non-alphabetic character. Please enter your age again."
  end
end

def reply(name)
  return "HI #{name.chop.upcase}, WHY ARE YOU SHOUTING" if name.include?("!")
  "Hi, #{name}!"
end

name = ask_name
puts reply(name)

# 6. Print all odd numbers from 1 to 99, inclusive. All numbers should be printed on separate lines.

[*1..99].each { |num| puts num if num.odd? }

# 7. Sames as 6, but for even numbers

[*1..99].each { |num| puts num if num.even? }

# 8. Write a program that asks the user to enter an integer greater than 0, then asks if the user
# wants to determine the sum or product of all numbers between 1 and the entered integer.

def get_number
  loop do
    puts "Enter a number:"
    num = gets.chomp
    return num.to_i if num.to_s.chars.all? { |digit| NUMBERS.include?(digit) }
    puts "You inserted an invalid number. Please enter your age again."
  end
end

def get_operation
  loop do
    puts "Do you want to perform a sum ('sum') or multiplication ('multiply')?"
    operation = gets.chomp.downcase
    return operation if operation == "sum" || operation == "multiply"
    puts "You inserted an invalid option. Please try again."
  end
end

def display_result(operation, number)
  return [*1..number].sum if operation == "sum"
  [*1..number].inject(&:*)
end

number = get_number
operation = get_operation

display_result

# 9. What does this print?

name = 'Bob' # name points to the object with data "Bob"
save_name = name # save_name points to the object pointed by name at this point
name.upcase! # "Bob" is mutated to "BOB"
puts name, save_name # "BOB" \n "BOB"

# 10. What does this print?

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo) # Array of words
array2 = []
array1.each { |value| array2 << value } # Array 2 now == Array 1
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2 # %w(Moe Larry CURLY SHEMP Harpo CHICO Groucho Zeppo)

=begin
An array has its own object id, but within it each element has its individual object id.
In that sense, mutating an object in another array also mutates the same object
found elsewhere — be it in variables or other arrays.
=end