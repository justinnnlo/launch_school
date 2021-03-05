# 1. Generate a random number between 20 and 200 and output that

def teddy_age
  puts "Teddy is #{rand(20..200)} years old!"
end

# 2. Ask the user for the length and width of a room in meters and display the AREA in both square meters and feet.

meters_to_feet = 10.7639

puts "=> What's the length of the room in meters?"
length = gets.chomp.to_i

puts "=> What's the width of the room in meters?"
width = gets.chomp.to_i

puts "The room is #{length * width} square meters (#{length * width * meters_to_feet} square feet)."

# 3. Prompt the bill amount and tip rate. Then display the tip and total amount.

def tip_calculator
  puts "=> What's the size of the bill?"
  bill = gets.chomp.to_i
  puts "=> What's the tipping rate? Please enter an integer (i.e. 15 is 15%)"
  rate = gets.chomp.to_f / 100        # gets.chomp.to_i / 100 will equal 0 if rate < 100! So use floats always for something like this

  tip = bill * rate

  puts "The tip is $#{tip}"
  puts "The total is $#{tip + bill}"
end


# 4. Ask the user his age and when he'd like to retire. Return the age difference and year it'll be.

def retire_calculator
  puts "=> What's your age?"
  age = gets.chomp.to_i
  puts "=> At what age would you like to retire"
  age_retire = gets.chomp.to_i

  year_to_go = age_retire - age

  puts "It's #{Date.today.year}. You will retire in #{Date.today.year + year_to_go}"
  puts "You have #{year_to_go} years left!"
end

# 5. Ask for the user's name. If the computer writes his name with an exclamation mark screem back.

def ask_name
  puts "=> what's your name?"
  name = gets.chomp

  if name.include?("!")
    puts "HELLO #{name.upcase}. WHY ARE WE SCREAMING?"
  else
    puts "Hello #{name.capitalize}."
  end
end

# 6. Print all odd number from 1 too 99 in separate lines

[*1..99].each { |num| puts num if num.odd? }

# 7. Print all even number from 1 too 99 in separate lines

[*1..99].each { |num| puts num if num.even? }

# 8. Ask the user for an integer greated than 1. Then ask if he wants to sum or product of all integers between 1 and his entered integer. Assume no validation is necessary.

def add_or_multiply
  puts ">> Please enter an integer greater than 0:"
  num = gets.chomp.to_i
  puts ">> Enter 's' to compute the sum, 'p' to compute the product."
  action = gets.chomp

  if action == "s"
    puts "The sum of the integers between 1 and #{num} is #{[*1..num].sum}."
  else
    product = [*1..num].inject { |acc, ele| acc * ele }
    puts "The product of the integers between 1 and #{num} is #{product}."
  end
end



# 9. What does the code print?

name = 'Bob'
save_name = name      # "Bob"
name = 'Alice'        # "Alice"
puts name, save_name  # "Alice", "Bob"

name = 'Bob'
save_name = name      # "Bob"
name.upcase!          # "BOB"
puts name, save_name  # "BOB", "BOB"



# 10. What does the code print?

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2 # [Moe, Larry, CURLY, SHEMP, Harpo, CHICO, Groucho, Zeppo]