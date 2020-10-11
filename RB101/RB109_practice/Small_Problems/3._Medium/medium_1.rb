require "byebug"

=begin

Input: array of elements
Output: array of elements

Problem: move the first element to the end and return it as a new array

Example
  - ['a', 'b', 'c'] => ['b', 'c', 'a']

Algorithm:
  - Initialize "result" and bind it to a clone of the array
  - Append a value of the first element and then remove the first element
  - Return result
=end

def rotate_array(arr)
  result = arr.clone
  result << result[0]
  result.shift
  result
end

p rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
p rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
p rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
p rotate_array(x) == [2, 3, 4, 1]   # => true
x == [1, 2, 3, 4]                 # => true

=begin

Input: Number (integer) and last n digits to rotate (integer)
Output: integer

Problem: rotate the specific numbers once

Algorithm:
- Convert number to string
- Slice string[-n..-1], convert it to an array, send it to rotate_array, and join its return value
- Return string[0...-n] + return value of the joined array

=end

def rotate_rightmost_digits(number, place)
  array = number.to_s.chars

  (array[0...-place] + rotate_array(array[-place..-1])).join("").to_i
end

p rotate_rightmost_digits(735291, 1) == 735291
p rotate_rightmost_digits(735291, 2) == 735219
p rotate_rightmost_digits(735291, 3) == 735912
p rotate_rightmost_digits(735291, 4) == 732915
p rotate_rightmost_digits(735291, 5) == 752913
p rotate_rightmost_digits(735291, 6) == 352917


=begin

Input: integer
Output: integer

Problem: do the maximum rotations possible of a number

Algorithm:
- Call the rotate:rightmost_digits method and pass it the number
- The place parameter of the method should start at its length and iterate once until it reaches 1
  - Counter that decreases one per each iteration and breaks when it's one?

=end

def max_rotation(integer)
  count = integer.to_s.length

  count.downto(1) do |n|
    integer = rotate_rightmost_digits(integer, n)
  end

  integer
end

p max_rotation(735291) == 321579
p max_rotation(3) == 3
p max_rotation(35) == 53
p max_rotation(105) == 15 # the leading zero gets dropped
p max_rotation(8_703_529_146) == 7_321_609_845


=begin

Input: integer
Output: array of integers

Problem:
  - All lights start as off
  - Every run you switch the lights of the numbers who are multiples of the current number
    - Round 1: All switches
    - Round 2: 2, 4, 6...
    - Round 3: 3, 6, 9...
  - Return the lights that are on by the end

Algorithm:
  - Initialize an empty hash with a block { false } to signal its off (true signals they're on)
  - Do 1 upto the integer parameter
    - For 1..integer — MISSED: only if hash key is a multiple of the current number
      - If hash[n] == false, hash[n] = true
      - Else, hash[n] = false
  - At the end of the iteration, select all keys that have a value true

=end

def lights_on(integer)
  hash = Hash.new { false }
  1.upto(integer) { |n| hash[n] = false }

  1.upto(integer) do |n1|
    (n1..integer).each do |n2|
      if n2 % n1 == 0
        hash[n2] == false ? hash[n2] = true : hash[n2] = false
      else
        next
      end
    end
  end

  hash.select { |k, v| v == true }.keys
end

p lights_on(1) #=> [1]
p lights_on(2) #=> [1]
p lights_on(3) #=> [1]
p lights_on(4) #=> [1, 4]
p lights_on(5) #=> [1, 4]
p lights_on(10) #=> [1, 4, 9]


=begin

Input: odd integer
Output: diamond display with the width of the input

Algorithm
  - Return "*" if integer == 1
  - Initialize variables
    - asterix_product = 0
    - space_ product = input size
    - hash = {}
  - For each odd number from 1..integer
    - If the current number is odd
      - hash[integer] = space * ((space_product - 1) / 2) + (1 + asterix_product) + space * ((space_product - 1) / 2)
      - asterix_product += 2 and space_product -= 2
  - Do 1 up to integer and print hash[integer] if integer is odd AND (integer - 2) downto 1 and print hash[integer] if integer is odd

puts "*"

puts " * "
puts "***"
puts " * "

puts "  *  "
puts " *** "
puts "*****"
puts " *** "
puts "  *  "

(7 - 1 / 2) + (1 + 0) + (7 - 1 / 2) => 7 es ending number
(5 - 1 / 2) + (1 + 2) + (5 - 1 / 2) = 5 es ending number - 2
(3 - 1 / 2) + (1 + 4) + (3 - 1 / 2)
(1 - 1 / 2) + (1 + 6) + (1 - 1 / 2) => q + 6 == ending number y lados == starting number - 1

puts "   *   " => " " * 3 + "*" + " " * 3
puts "  ***  " => " " * 2 + "*" * 3 + " " * 2
puts " ***** " => " " * 1 + "*" * 5 + " " * 1
puts "*******" => " " * 0 + "*" * 7 + " " * 0
puts " ***** " => " " * 1 + "*" * 5 + " " * 1
puts "  ***  " => " " * 2 + "*" * 3 + " " * 2
puts "   *   " => " " * 3 + "*" + " " * 3

puts "' ' * (integer - 1)/2 + "*" *  ' ' * (integer - 1)/2"

=end

def create_hash(integer)
  asterix_product = 0
  space_product = integer
  hash = {}

  1.upto(integer) do |n|
    next if n.even?
    hash[n] = "#{' ' * ((space_product - 1) / 2)}#{'*' * (1 + asterix_product)}#{' ' * ((space_product - 1) / 2)}"
    asterix_product, space_product = asterix_product + 2, space_product - 2
  end
  hash
end

def display_diamond(hash, integer)
  1.upto(integer) { |n| puts hash[n] if n.odd? }
  (integer - 2).downto(1) { |n| puts hash[n] if n.odd? }
end

def diamonds(integer)
  hash = create_hash(integer)
  display_diamond(hash, integer)
end

diamonds(1)
diamonds(7)
diamonds(9)
diamonds(15)
diamonds(21)
diamonds(22)


=begin

Stack: a list of values that grows and shrinks dynamically — ie an array with push and pop methods

Stack and register programming language: a language that uses a stack of values
  - Each operation operates on a register, which is the current value
  - The register is not part of the stack

If an operation requires 2 values
  - It pops the topmost value
  - It does the operation with the register and the topmost value
  - Saves the result to the register

Example:
  - 3 6 4 (stack) MULT 7 (register)   => 4 is top of stack
  - 3 6 (stack) MULT 28 (register)    => 4 is removed and multiplied with 7
  - 3 (stack) MULT 168 (register)     =>
  - 504 (register)

Problem: create a simple stack and register programming language with the following commands
  1. `n`: place the value `n` in the register (does not modify the stack)
  2. `PUSH`: Push the register value to the stack and leave the value in the register (what does the last part mean?)
  3. `ADD`: pops the value from the stack, add it with the register, and store the result to the register
  4. `SUB`: pops a value from the stack, substracts it from the register, and stores the result to the register
  5. `MULT`: pops a value from the stack, multiplies it with the register, and stores the result to the register
  6. `DIV`: pops a value from the stack, divides it (as the denominator) with the register, and stores the result to the register
  7. `MOD`: pops a value from the stack, divides it with the register, and stores the integer remainder to the register
  8. `POP`: Remove the topmost value of the stack and place it in the register
  9. `PRINT`: print the register value

  Data types:
    - Input: string of commands
      - Array: to isolate commands
      - Integers: to manipulate numbers and their operations,
    - Output: integers

  Assumption: all programs are correct!

  Examples:
    minilang("PRINT") => 0 because register is initialized to 0
    minilang("5 PUSH 3 MULT PRINT") => 5 is added to the stack, 3 is set as the register, it multiplies the stack with the register, and prints the stack

  Algorithm
    - Parameter of string
    - Split the string by spaces
    - Initialize register to 0
    - Initialize the stack to an empty array
    - Iterate through the split string
      - if array element turned to integer and returned to string is equal to the element, its an integer
        - Assign to register
      - Otherwise, send the array element with the stack and register to a method that interprets the command and performs the desired action
=end

def execute_command(register, stack, command)
  case command
  when "PRINT" then p register
  when "PUSH"  then stack.push(register).slice(0) # Without slice returns an array as push returns an array
    #stack << register # Otherwise returns an array
    #register
  when "ADD"   then register + stack.pop
  when "SUB"   then register - stack.pop
  when "MULT"  then register * stack.pop
  when "DIV"   then register / stack.pop
  when "MOD"   then register.modulo(stack.pop)
  when "POP"   then stack.pop
  else              command.to_i
  end
end

def minilang(string)
  register = 0
  stack = []

  string.split(" ").each { |command| register = execute_command(register, stack, command) }
end

# execute_command(5, [], "PRINT")
# p execute_command(5, [], "PUSH")
# p execute_command(5, [5], "ADD")
# p execute_command(5, [5], "SUB")
# p execute_command(5, [5], "MULT")
# p execute_command(5, [5], "DIV")
# p execute_command(5, [5], "MOD")
# p execute_command(5, [5], "MOD")


# stack = []
# register = 3
# register = execute_command(register, stack, "PUSH")
# register = execute_command(register, stack, "PUSH")
# register = 7
# register = execute_command(register, stack, "DIV")
# register = execute_command(register, stack, "MULT")
# p register = execute_command(register, stack, "PRINT")

minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12 => wrong, prints 4

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
# (nothing printed; no PRINT commands)


=begin

Input: sentence
Return: String

Problem: Change the words of the strings into string integers

Algorithm
  - Split the string
  - Create a case statement where the word is changed to the string integer. Else, same string
  - Do a map and pass the input into the case statement
  - Join the resulting array

=end

def word_to_int(string)
  punctuation = ""
  string, punctuation = string[0...-1], string[-1] if string[-1] == "." || string[-1] == ","
  case string
  when "zero"  then "0" + punctuation
  when "one"   then "1" + punctuation
  when "two"   then "2" + punctuation
  when "three" then "3" + punctuation
  when "four"  then "4" + punctuation
  when "five"  then "5" + punctuation
  when "six"   then "6" + punctuation
  when "seven" then "7" + punctuation
  when "eight" then "8" + punctuation
  when "nine"  then "9" + punctuation
  else              string + punctuation
  end
end

def word_to_digit(string)
  string.split.map { |ele| word_to_int(ele) }.join(" ")
end

p word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'

=begin

FURTHER EXPLORATION

* Using gsub
* Allowing for a mix of upper and lowercase words

=end

=begin

Write a recursive fibonacci method
Examples:
  - F(1) = 1
  - F(2) = 1
  - F(3) = 2
  - F(4) = 3

Algorithm
- BAse cases: F1 = 1 && F2 == 2
- F0 <= 0 => 0
- F(n) + F(N - 1)

=end

def fibonacci(integer)
  return 1 if integer == 1 || integer == 2
  fibonacci(integer - 1) + fibonacci(integer - 2)
end

p fibonacci(1) == 1
p fibonacci(2) == 1
p fibonacci(3) == 2
p fibonacci(4) == 3
p fibonacci(5) == 5
p fibonacci(12) == 144
p fibonacci(20) == 6765


=begin
Do Fibonacci without recursion

Algorithm
- first = 1
- last = 1
- Go from 3 to the integer
  - first, last = [last, first + last]

  What's the trick? It saves the new pairs of numbers so it's less computationally intensive!
=end

def procedural_fibonacci(integer)
  return 1 if integer == 1 || integer == 2
  first, last = [0, 1]

  3.upto(integer) { first, last = [last, first + last] }
  first + last
end

p procedural_fibonacci(20) == 6765
p procedural_fibonacci(100) == 354224848179261915075
p procedural_fibonacci(100_001) # => 4202692702.....8285979669707537501


=begin

Problem: get the last digit of the nth fibonacci #

Intput: integer
Output: integer

Data types: string to slice and get the last number

Algorithms: use procedural_fibonaci, convert to string, slice the last index, and convert that to integer

=end

def fibonacci_last(integer)
  string = procedural_fibonacci(integer).to_s
  string[-1].to_i
end

p fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
p fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
p fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
p fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
p fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
p fibonacci_last(123456789) # -> 4
