# Defining a what is a variable

Variables store information to later reference and manipute them in programs. It's also used to label a piece of data with a descriptive name (it, that describes the data in question) to make it more clear to the reader of the program.

Thus, a variable is a container that labels and stores data in the computer's memory.

# Assigning value to variables

**Naming variables is one of the biggest challenges programming**.

Variables are *assigned* with the '=' symbol. Assigning a variable associates the variable name with its value, and assigns it a memory location.

Variables point to values in memory — they are not *deep linked* to each other.

For example,

a = 4 #object_id = 9
b = a #object_id = 9
a = 7 #object_id = 15
b = ?

As b = a and a = 4, b = 4 

Here,

# Getting data from users

The `gets` method (ie gets string) allows us to get user input as a string.

`chomp` method allows us to remove whitespaces and newlines — which is important because if a user hits enter it returns his input plus the newline.

# Variable scope

A variable scope determines where you can use a variable in a program.

A variable´s scope is determined by where the variable is initialized.

Crucially, the **inner scope can access variables defined in the outer scope** but not vice versa. When a variable is accessed it can be used in any way regardless of scope.

In Ruby, variable scopes are defined by a block. A block is a piece of code delimineted by {} or do/end. 

The crucial distinction is that a new variable scope is defined following the invocation/calling of a method.

For example,
~~~
a = 5

3.times do |n|    # invoking the method times with a block
  a = 3
  b = 5           # b is initialized in the inner scope
end

puts a
puts b            # b is inaccessible here, in the outer scope?
~~~