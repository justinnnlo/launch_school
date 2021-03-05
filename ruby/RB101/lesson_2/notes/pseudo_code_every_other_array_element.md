# Problem

Take an array of integers and return a new array with every other element.

Assumption: even number of elements

# Examples

[1, 2, 3, 4, 5] => [1, 3, 5]
[10, 5, 6, 7] => [10, 6]
[10, 5, "Hello"] => Raise error "The array can only have elements of type integer"

# Data structures

Array and integers for its elements

# Algorithms

We need to iterate through the array, verify the element is an integer, and use the select method on odd elements.

# Pseudo code

START

Create method every_other_integer(array)
  Select method to iterate through each element of the array and its index
    IF element class != Integer
      raise "The array can only have elements of type integer"
    ELSE
      Select if index == odd
    
END

# Code

def every_other_integer(array)
  array.select.with_index do |ele, index|
    if ele.class != Integer
      raise "The array can only have elements of type integer"
    else
      index.even?
    end
  end
end
