# DOCUMENTATION

# 1. Where can you find the most complete Ruby documentation?
# Online or in pry

# 3. What does the while loop return? => nil, unless break is used to supply a value (e.g. break "This is returned")

# 4. What value does break return? => break returns nil or the evaluated expression in its line (e.g. break "This is returned")

# 5. Using the ruby documentation, determine how you can write large numbers in a way that makes them easier to read.

# Within the section "literals", it says we can use underscores to visualize a large number — e.g. 100_000_000. Howeverm it's still printed as 100000000.

# 6. Using the ruby documentation, determine how you would write a Symbol that represents your name. 

# Again under literals, we find that it'd be :Jose_Agustin_de_la_Puente. The underscore is necessary for Ruby to interpret it as a single object that is a symbol.

# 8. How would you use String#upcase to create an uppercase version of the string "xyz"?

# Documentation: upcase → new_str => implies [original string] → [value returned]

"xyz".upcase

# 9. How would you use the insert method to insert the numbers 5, 6, and 7 between the elements with values 'c' and 'd'?
a = %w(a b c d e) # ["a", "b", "c", "d", "e"]
a.insert(3,5,6,7) # ["a", "b", "c", 5, 6, 7, "d", "e"]

# Documentation tip: how do we display 0 or more arguments? 1. obj..., 2. *obj, 3. [obj]*. If no argument is sent, nothing changes.

# 10. What will each of the 3 puts statements print?

s = 'abc def ghi,jkl mno pqr,stu vwx yz'
puts s.split.inspect # A string representing the array of s split by its whitespaces
puts s.split(',').inspect # A string representing the array of s split by its commas
puts s.split(',', 2).inspect # A string representing a element array given the split limit of 2: ["abc def ghi", "jkl mno pqr,stu vwx yz"]