# 1. What will the following code print? Why?

# Gist: what does returning a value imply and how we can manipulate it

def meal
  return 'Breakfast' # returns the value "Breakfast"
  
  # When return is executed it exits the method and provides the value of the last evaluated expression
end

puts meal # Prints the value returned by meal



# 2. What will the following code print? Why?

# Gist: implicit returns

def meal
  'Evening' # implicitly returns
end

puts meal # puts "Evening"



# 3. What will the following code print? Why?

# Gist: control flow with return

def meal
  return 'Breakfast' # Program returns "Breakfast" and leaves the method
  'Dinner' # Not executed
end

puts meal # puts "Breakfast"



# 4. What will the following code print? Why?

# Gist: mixing puts and returns

def meal
  puts 'Dinner' # prints Dinner
  return 'Breakfast' # then returns Breakfast
end

puts meal # prints Breakfast



# 5. What will the following code print? Why?

# Gist: mixing prints and return methods

def meal
  'Dinner' # prints nothing
  puts 'Dinner' # prints "Dinner"
end

p meal # returns the value puts "Dinner". First p, then puts Dinner? - WRONG

# p puts meal = p nil because puts mean RETURNS nil



# 6. What will the following code print? Why?

# Gist: control flow with return and puts

def meal
  return 'Breakfast' # returns Breakfast and exits method
  'Dinner'
  puts 'Dinner'
end

puts meal # prints "Breakfast"



# 7. What will the following code print? Why?

# Gist: returning and printing with methods

def count_sheep
  5.times do |sheep| # counts 0...5 and returns 5
    puts sheep
  end
end

puts count_sheep # prints 0, 1, 2, 3, 4 and then puts the return value of the times method (5) and RETURNS nil per puts' standard characteristics



# 8. What will the following code print? Why?

# Gist: method returns and print

def count_sheep
  5.times do |sheep|
    puts sheep # prints 0, 1, 2, 3, 4
  end
  10 # returns 10
end

puts count_sheep # puts 10



# 9. What will the following code print? Why?

# iterations with conditionals and explicit returns without arguments

def count_sheep
  5.times do |sheep|
    puts sheep # prints 0, 1, 2
    if sheep >= 2
      return # return nil
    end
  end
end

p count_sheep # print nil and return nil



# 10. What will the following code print? Why?

# Gist: implicit return with variable assignment, conditionals with booleans

def tricky_number
  if true # if true == execute if
    number = 1 # returns 1 because of the assignment, though an implicit return of 1 would've still worked because an integer returns its own value
  else
    2
  end
end

puts tricky_number # print 1, return nil