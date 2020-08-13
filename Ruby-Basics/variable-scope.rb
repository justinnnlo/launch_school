#Problem 1 

a = 7

def my_value(b)
  b += 10
end

my_value(a) # Return 17
puts a # print 7 and return 7 because a is not mutated within a variable scope

=begin

Reassignment does NOT mutate the variable — it binds the output to a new object. Hence, a += 10 implies 2 objects: the original a = 7 and the second a = 10

Additionally, **numbers** are inmutable — their object_ids cannot be changed. 
=end

# Part 2
a = 7

def my_value(a)
  a += 10 # Does not mutate the variable 
end

my_value(a) # returns 17
puts a #print 7, return 7

# This exercise teaches that local variables are placeholders that can have any value.

#Part 3
a = 7

def my_value(b)
  a = b
end

my_value(a + 5) # return 5
puts a 