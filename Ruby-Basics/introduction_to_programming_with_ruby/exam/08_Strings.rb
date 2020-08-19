
# 1. Create an empty string using the String class and assign it to a variable.

# Gist: creating empty strings, using class methods

empty_string = String.new # Originally String.new(""), but the latter is unnecessary

# Alternative: empty_string = ""



#2. Modify the following code so that double-quotes are used instead of single-quotes.

# Gist: compare single and double quotes, and escaping characters

puts "It's now 12 o'clock." # Remove backslant (\) because we don't need to escape single quotes within double quotes

# Further exploration of syntax:
# Double quotes: %Q()
# Single quotes: %q()

puts %Q(It's now 12 o'clock.)
puts %q(It\'s now 12 o\'clock.) # Error: in this syntax we don't need to use escape sequences for single quotes in the text



# 3. Using the following code, compare the value of name with the string 'RoGeR' while ignoring the case of both strings. Print true if the values are the same; print false if they aren't. Then, perform the same case-insensitive comparison, except compare the value of name with the string 'DAVE' instead of 'RoGeR'.

# Gist: string comparisons and using methods for case-insensitive comparions

name = 'Roger'

puts name.downcase == "RoGeR".downcase
puts name.downcase == "DAVE".downcase

# Alternative: puts name.casecmp("RoGeR") == 0, where == 0 means the strings are the same and should print true



# 4. Modify the following code so that the value of name is printed within "Hello, !".

# Gist: string interpolation with variables - which automatically converts the objects to string

name = 'Elizabeth'

puts "Hello, #{name}!"



# 5. Using the following code, combine the two names together to form a full name and assign that value to a variable named full_name. Then, print the value of full_name.

# Gist: how to combine strings

first_name = 'John'
last_name = 'Doe'

full_name = first_name + " " + last_name
puts full_name

#Other alternatives: string interpolation and concatenation
full_name = "#{first_name} #{last_name}"

# With mutation - like << but for multiple arguments
full_name = ""
full_name.concat(first_name, " ", last_name)



# 6. Using the following code, capitalize the value of state then print the modified value. Note that state should have the modified value both before and after you print it.

# Gist: string mutation

state = 'tExAs'

state.capitalize!
p state



# 7. Given the following code, invoke a destructive method on greeting so that Goodbye! is printed instead of Hello!.

# Gist: change a string by mutating it

greeting = 'Hello!'

for char in (0...greeting.length)
  greeting[0]=""
end

greeting << "Goodbye!"

puts greeting

# Alternatives:

# 1. gsub! method

greeting = 'Hello!'

greeting.gsub!('Hello', 'Goodbye')
puts greeting

# 2. String iteration
# Something like this could work, but I don't know well enought: (0...greeting.length).each { |index| greeting[index] = "" }



# 8. Using the following code, split the value of alphabet by individual characters and print each character.

# Gist: printing the elements of an array, splitting an alphabet into an array

alphabet = 'abcdefghijklmnopqrstuvwxyz'

split_alphabet = alphabet.split("")

split_alphabet.each { |char| puts char }

# IMPROVED version

puts alphabet.split("") # Because putting an array prints each element in a newline



# 9. Given the following code, use Array#each to print the plural of each word in words.

# Gist: append "s" at the end of each element split from a string

words = 'car human elephant airplane'

words.split.each { |word| puts word + "s" }



# 10. Using the following code, print true if colors includes the color 'yellow' and print false if it doesn't. Then, print true if colors includes the color 'purple' and print false if it doesn't.

# Gist: find a substring within a string

# OPTIMIZED version: include directly on the string

colors = 'blue pink yellow orange'

puts colors.include?("yellow")
puts colors.include?("purple")

# Further Exploration

colors = 'blue boredom yellow'

puts colors.include?('red') # Expected output: true because it parses for the substring, which is included in boredom!

# Original version: splitting strings
# ERROR: should've called include? to the entire string "colors" rather to a split array of it

colors = 'blue pink yellow orange'

split_colors = colors.split

puts split_colors.include?("yellow")
puts split_colors.include?("purple")