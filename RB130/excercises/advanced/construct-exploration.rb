# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc        # Proc object
puts my_proc.class  # Proc
my_proc.call        # Displays "This is a .", return nil
my_proc.call('cat') # Displays "This is a cat.", return nil

# # Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}." }           # Proc lambda object
my_second_lambda = -> (thing) { puts "This is a #{thing}." }        # Proc lambda object
puts my_lambda                                                      # Proc lambda object
puts my_second_lambda                                               # Proc lambda object
puts my_lambda.class                                                # Proc object
my_lambda.call('dog')                                               # "This is a dog."
my_lambda.call                                                      # ArgumentError: expected 1 argument
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." } # NameError

# # Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}  # "This is a ."
block_method_1('seal')                                      # LocalJumpError

# # Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}  # "This is a turtle."
block_method_2('turtle') do |turtle, seal|                        # This is a turtle and a .
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}           # NameError: undefined local variable

=begin
Conclusion:

A lambda is a proc object with more stirngest arity rules.

A lambda object can be intialized via:
1. lambda { |par| }
2. -> (par) { }

It cannot be initialized via Lambda.new because it isn't a class.

Unlike Proc and blocks, a lambda returns an argument error if the number of arguments passed does not match the number of arguments it was expecting. In that sense, it's analogous to how a method definition's arity rules and how it works with parameters.
=end