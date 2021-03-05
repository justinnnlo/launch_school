# 1. Write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right.

def flintstones
  num = 1
  puts "The Flintstones Rock!"

  while num < 10
    puts (" " * num) + "The Flintstones Rock!"
    num += 1
  end
end

flintstones

# Idiomatic Ruby: " " * 0 = ""
10.times { |num| puts (" " * num) + "The Flintstones Rock!"}

# 2. What are 2 ways to fix the error?

#puts "the value of 40 + 2 is " + (40 + 2)

# Error: operating string with integer without conversion

puts "the value of 40 + 2 is #{40+2}" # String interpolation
puts "the value of 40 + 2 is " + (40 + 2).to_s

# 3. How can you make this work with a 0 or negative number without using begin/end/until?

def factors(number)
  divisor = number
  factors = []
  if number > 0
    while divisor > 0
      factors << number / divisor if number % divisor == 0
      divisor -= 1
    end
  else
    while divisor < 0
      factors << number / divisor if number % divisor == 0
      divisor += 1
    end
  end
  factors
end

=begin
2 alternatives with the drawback of not working for negative numbers without abs
def factors(number)
  divisor = number.abs
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# def factors(number)
#   divisor = number
#   factors = []
#   for num in (1..divisor)
#     factors << num if number % num == 0
#   end
#   factors
# end
=end

factors(-20)

# 4. "Do you like << or + for modifying the buffer?". Is there a difference between the two, other than what operator she chose to use to add an element to the buffer?"

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element # Mutates the object: ideal in terms of memory
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element] # Reassigns the variable
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# 5. What's wrong?

limit = 15

def fib(first_num, second_num, limit)
  while first_num + second_num < limit # Limit is not passed as an argument to the method and it's a self-contained scope
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"

# 6. What's the output?

answer = 42

def mess_with_it(some_number)
  some_number += 8 # Does not mutate
end

new_answer = mess_with_it(answer) # new_answer = 50

p answer - 8 # 42 - 8 = 34 because "-" has a preference over "p"

# 7. Is the data ransacked?

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

mess_with_demographics(munsters)

=begin
Answer: no, because the elements within the hash were not mutated — they were reassigned within a copy of the object pointed by munsters.

WRONG: why?

Ruby passes the object id of an object to a method rather than the variable per se. It then stores these ids in their local variables (in this case, demo_hash).

However, it doesn't **copy** the object. Thus, reassigning its elements didn't mutate the hash but changed the elements within it.
=end

# 8. What's the result of the call?

def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock") # paper

# 9. What's the return value?

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

bar(foo) # bar("yes") => param = "yes", param == "no" => "no"
