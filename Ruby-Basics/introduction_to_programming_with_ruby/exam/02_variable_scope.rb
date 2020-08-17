
#1. What will the following code print and why?

a = 7

def my_value(b) # Local variable b points to the same object as variable a
  # Method definition: in a separate execution flow
  b += 10 # Reassignment binds the variable to point to a new object
end

my_value(a)
puts a # prints 7



# 1.b Why is this different to the above?

=begin
2 reasons:
i) each array has a unique object_id
ii) pop mutates the object

In contast, while reassignement does not mutate the value referenced by the variable — it just binds itself to a new value.
=end

test = [1, 2, 3] # Each array has a unique object_id, vs numbers which are inmutable and always have the same

def pop!(test)
  test2 = test
  test2.pop # test2 is pointing to the same object as test and mutates the object via pop
  test2
end

pop!(test)
puts "Test is #{test}"



# 2. What will the following code print and why?

# This is an identical problem than the above
# Why is it shown? To stress that argument names are placeholders and can be anything because they're in their own execution scope

a = 7

def my_value(a)
  a += 10 # local variable a of the method is reassigned to 17
end

my_value(a) # 17 given
puts a # 1. Numbers are inmutable and 2. it was a local variable within a method, not the same a outside of it



# 3. What will the following code print and why?

# This problem stresses that variables within methods are outside of the execution of the regular program, and thus cannot invoke local variables outside of the method

a = 7

def my_value(b)
  a = b # Assigns the new variable a, within the method's scope, the value of 12
end

my_value(a + 5) # Passes as an argument 12
puts a # 7



# 4. What will the following code print and why?

# The lesson explores 3 topics: indices, object mutation, and variable and method scope

a = "Xyzzy"

def my_value(b)
  b[2] = '-' # Mutates the object to include "-" in the 2nd index and returns "Xy-zy" because variable assignment returns the evaluated expression
end

my_value(a) # Passes the argument "Xyzzy"
puts a # "Xy-zy" because assigning a new index element in a string or array mutates the object



# 5. What will the following code print and why?

# Gist: local variables within a method are not equivalent to variables being passed to the method

a = "Xyzzy"

def my_value(b)
  b = 'yzzyX' # A new variable b is assigned the reverse of a, it does NOT mutate the object pointed by a
end

my_value(a) # Returns the value of b
puts a # Xyzzy because b is a local variable that is only passed the object of a



# 6. What will the following code print and why?

# Gist: Error messages and local variable scopes
# Where would this have worked? In blocks, procs and lambdas, which are all within the regular execution of the program

a = 7

def my_value(b)
  b = a + a # Raises an error because "a" is an undefined variable - it cannot be called within the scope of a method
end

my_value(a) # Returns the error
puts a # 7



# 7. What will the following code print and why?

# Gist: local variables can be accessed within scopes because they're within the regular execution of the program

a = 7
array = [1, 2, 3]

array.each do |element| # each method returns the value of the array variable
  a = element # a is reassigneded to the value of each element of array
end

puts a # 3 because it's the last element that "a" was reassigned to



# 8. What will the following code print and why?

# Gist: blocks create a new variable scope. By extension, variables created there that cannot be accessed outside of it

array = [1, 2, 3]

array.each do |element|
  a = element # A block creates an inner scope that can access variables outside of it, but not vice versa
end

puts a # Returns an error: a is an undefined variable because it only exists within the scope of the array.each block



# 9. What will the following code print and why?

# Gist: "shadowing" means using a variable's name as a placeholder within a block, which implies that the variable itself is inaccessible (because it's been "shadowed" by the block placeholder)

a = 7
array = [1, 2, 3]

array.each do |a| # The block iterates through each element of the array and calls each element with the alias "a"
  a += 1 # "a" within the block refers to each element of the array. This doesn't mutate the array - each isn't destructive
end

puts a # 7



# 10. What will the following code print and why?

# Gist: having a block within a method definition still means that the method is outside the regular execution of the program

a = 7
array = [1, 2, 3]

def my_value(ary) # ary has the value of array
  ary.each do |b| # Iterate through each element (b) of ary
    a += b # undefined variable error: this is within a method definition
  end
end

my_value(array) # Returns error
puts a # 7