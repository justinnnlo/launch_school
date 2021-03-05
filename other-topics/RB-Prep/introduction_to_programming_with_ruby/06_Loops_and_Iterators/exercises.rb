require "byebug"
# 1. What does the each method in the following program return after it is finished executing?

x = [1, 2, 3, 4, 5] #each returns the original object, in this case: [1, 2, 3, 4, 5]
x.each do |a|
  a + 1
end

# 2. Write a while loop that takes input from the user, performs an action, and only stops when the user types "STOP". Each loop can get info from the user.

p "Write START to commence"
input = gets.chomp
while input != "END"
  p "We're in a MERRY-GO-ROUND"
  p "END or not?"
  input = gets.chomp
end

# 3. Write a method that counts down to zero using recursion.

def to_zero(x)
  if x > 0
    p x -= 1
    to_zero(x)
  elsif x == 0
    return "x is 0!"
  else
    return "Something's wrong — x can't be smaller than 0!"
  end
end



# My ORIGINAL trial

# Problem 1: What does the each method in the following program return after it is finished executing?

x = [1, 2, 3, 4, 5]
x.each do |a|
  a + 1
end

# It returns the x array as in line 3 because the each loop did not modify the elements of the variable

# Problem 2: Write a while loop that takes input from the user, performs an action, and only stops when the user types "STOP". Each loop can get info from the user.

while true
  puts "Do you want to do the loop again? Input STOP to exit."
  x = gets.chomp # .chomp is needed — but why? Unclear.
  if x == "STOP"
    break
  end
end

# Problem 3: Write a method that counts down to zero using recursion.

def to_zero(n)
  if n == 0
    return n
  elsif n < 0
    return "The number's less than 0!"
  else
    p n
    to_zero(n-1)
  end
end

p to_zero(10)