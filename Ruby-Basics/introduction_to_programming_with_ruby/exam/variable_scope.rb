# 1. What will the following code print and why?

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