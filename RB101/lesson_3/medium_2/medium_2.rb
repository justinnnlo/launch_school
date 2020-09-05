# 1. Predict how the values and object ids will change throughout the flow of the code below:

def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0] # => 42 == a_outer

  a_outer_id = a_outer.object_id # 1
  b_outer_id = b_outer.object_id # 2
  c_outer_id = c_outer.object_id # 3
  d_outer_id = d_outer.object_id # 1

  # All correct!
  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  1.times do
    a_outer_inner_id = a_outer.object_id # 1
    b_outer_inner_id = b_outer.object_id # 2
    c_outer_inner_id = c_outer.object_id # 3
    d_outer_inner_id = d_outer.object_id # 1

    # All correct
    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
    puts

    a_outer = 22 #1.2
    b_outer = "thirty three" # 2.2
    c_outer = [44] #3.2
    d_outer = c_outer[0] #4.2

    # All correct
    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
    puts


    a_inner = a_outer # 1.2
    b_inner = b_outer # 2.2
    c_inner = c_outer # 3.2
    d_inner = c_inner[0] # 4.2

    a_inner_id = a_inner.object_id # 1.2
    b_inner_id = b_inner.object_id # 2.2
    c_inner_id = c_inner.object_id # 3.2
    d_inner_id = d_inner.object_id # 4.2

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
    puts
  end

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block." # 1
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block." # 2
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block." # 3
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block." # 1
  puts

  # All below need to be rescued
  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
end

puts fun_with_ids

# 2. Put the loop in a method and run it. How is it similar and different?

# a. `inner` variables are still not available because they aren't returned
# b. Variable scope is now self-cointained and variables need to be passed
# c. `outer` variables are not reassigned or mutated because of the self-contained scope
# d. But inside the variable, the `outer` variables are different — they're the method's local variables



# 3. What will be displayed?

def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga" # Does not mutate the object — but the method's local variable is reassgiend to "pumpkinrutabaga". Ie, it creates a new string object and binds it to the variable
  an_array_param << "rutabaga" # Mutates the object by appending
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}" # "pumpkins"
puts "My array looks like this now: #{my_array}" # ["punpkins", "rutabaga"]

# 4. What will be displayed?

def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga' # Mutates the object to "pumpkinrutabaga"
  an_array_param = ['pumpkins', 'rutabaga'] # Creates a new object and assigns it to the method's local variable
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}" # "pumpkinrutabaga"
puts "My array looks like this now: #{my_array}" # ["pumpkin"]

# 5. Make the method easier to predict and maintain

def reassign_objects(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += "rutabaga"

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = reassign_objects(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# Problem: i) the method name does not say what it does and ii) for clarity ideally better to reassign within a method than mutate

# 6. How could the unnecessary duplication in this method be removed?

def color_valid(color)
  color == "blue" || color == "green"
end