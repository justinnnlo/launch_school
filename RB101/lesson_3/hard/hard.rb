# 1. What's the output?

if false # Evaluates to false, it does not execute
  greeting = “hello world”
end

greeting # NameError

# 2.What's the last line's output?

greetings = { a: 'hi' }
informal_greeting = greetings[:a] # "hi"
informal_greeting << ' there' # "hi there"

puts informal_greeting  #  => "hi there"
puts greetings # { :a => "hi" }

# WRONG! `informal_greeting` and `greeting[:a]` share the same object, which is then mutated in `informal_meeting`!

# If we want informal_meeting to not affect greeting? Clone the object: e.g. .clone method, which creates a new object with the same value.

# 3. What will they print?

def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # "one"
puts "two is: #{two}" # "two"
puts "three is: #{three}" # "three"



def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # "one"
puts "two is: #{two}" # "two"
puts "three is: #{three}" # "three"



def mess_with_vars(one, two, three)
  # object mutation with gsub!
  one.gsub!("one","two") # two
  two.gsub!("two","three") # three
  three.gsub!("three","one") # one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # two
puts "two is: #{two}" # three
puts "three is: #{three}" # one



# 4. Fix the code: a. return a false confition, b. 

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".") # e.g. "10.4.5.11" => ["10", "4", "5", "11"]
  return false if dot_separated_words.length != 4
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false if is_an_ip_number?(word) == false
  end
  true
end

puts dot_separated_ip_address?("10.4.5.11")
puts dot_separated_ip_address?("10.4.5")