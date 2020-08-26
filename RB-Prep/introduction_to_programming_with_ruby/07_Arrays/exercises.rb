# Problem 1: Write a program that checks to see if the number appears in the array.

arr = [1, 3, 5, 7, 9, 11]
number = 3

# Using the .include? method
arr.include?(3)

# Writing a custom method
def include_num?(arr, number)
  arr.each { |n| return true if n == number }
  return false
end

include_num?(arr, number)

# Problem 2: What will the following programs return? What is the value of arr after each?

  # Program 1
  arr = ["b", "a"]
  arr = arr.product(Array(1..3)) # [["b", 1], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]
  arr.first.delete(arr.first.last) # arr.first.delete("a") -> **nil** (NOT error), because there's no "a" to delete in the first subarray
  
  # Program 2
  arr = ["b", "a"]
  arr = arr.product([Array(1..3)]) # [[1, 2, 3]] -> [["b", [1, 2, 3]], ["a", [1, 2, 3]]] because [1, 2, 3] is a SINGLE element
  arr.first.delete(arr.first.last) # arr.first.delete([1,2,3]) -> returns [1,2,3] and the new array is: [["b"], ["a", [1, 2, 3]]]

# Problem 3: How do you return the word "example" from the following array? 

arr = [["test", "hello", "world"],["example", "mem"]]

# Solution 1: slicing
p arr[1][0]
# Solution 2: method chaining
p arr.last.first

# Solution 3: custom method with iteration 
def extract(arr)
  arr.each do |subarray|
    subarray.each { |word| word if word == "example"  }
  end
end

p extract(arr)

# Problem 4: What does each method return in the following example?

arr = [15, 7, 18, 5, 12, 8, 5, 1]

arr.index(5) # This method asks: in what index is the element 5? Result: 6 (wrong!) — it"s 3 because that's the first instance of 5 (missed it)

# arr.index[5] # Error

arr[5] # Result: 8, because it's the element in index 5

# Problem 5: What is the value of a, b, and c in the following program?

string = "Welcome to America!"
a = string[6] # "e"
b = string[11] # "A"
c = string[19] # nil -> because it does NOT have an index 19

# Problem 6: What is the problem of the error message and how can it be fixed?

names = ['bob', 'joe', 'susan', 'margaret']
# names['margaret'] = 'jody' # Here's the error: we're passing a string ("margaret") into an array that only handles numbers for indices

#Solution 1: use index method
names[names.index("margaret")] = "jody"

#Solution 2: place the index directly — it can be either 3 or -1 as it's the last element
names[3] = "jody"

=begin
TypeError: no implicit conversion of String into Integer
  from (irb):2:in `[]='
  from (irb):2
  from /Users/username/.rvm/rubies/ruby-2.5.3/bin/irb:12:in `<main>'
=end

# Problem 7: Use the each_with_index method to iterate through an array of your creation that prints each index and value of the array.

arr = [1, 2, 3, 4, 5, 6, 7]
arr.reverse!
arr.each_with_index { |e, i| p "Index: #{i}, element: #{e}" }

# Problem 8: 

def arr_plus_2(arr)
  new_arr = arr.map { |e| e+2 }
  p "The original array is #{arr}", "The new array is #{new_arr}"
end

arr_plus_2([1,2,3])