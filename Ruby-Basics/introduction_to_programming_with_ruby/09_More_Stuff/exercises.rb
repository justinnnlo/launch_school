# Problem 1: Write a program that checks if the sequence of characters "lab" exists in the following strings. If it does exist, print out the word.

def lab(string)
  return string if string.include?("lab")
  return "No match"
end

puts lab("laboratory")
puts lab("experiment")
puts lab("Pans Labyrith")
puts lab("elaborate")
puts lab("polar bear")

# Problem 2: wbat will this print and return?

=begin
Blocks can be passed into a method like any variable with the `def method_name(&block)` syntax

We can pass both blocks and parameters to the same method: `def method_name(&block, parameter)`

The ampersand (&) tells the method that the argument is a block and it could be named anything we want, as with any parameter

Blocks within a method need to be called with the `block.call` syntax  

=end
def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" } # puts method will print that message and return nil, as always