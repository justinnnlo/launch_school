# Ask the user for 2 numbers
# Ask the user for an operation to perform
# Perform the operation on the 2 numbers
# Output the result

# Note: this is a simpler approach to the calculator I previously made

require 'byebug'
require 'yaml'
MESSAGES = YAML.load_file("calculator_messages.yaml")
TEST = YAML.load('Hi, #{name}!')
byebug
def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  numbers = %w[0 1 2 3 4 5 6 7 8 9 .]

  num.split('').all? { |ele| numbers.include?(ele) } ? true : false

  # By comparing strings we problems of string-to-integer conversion, which always equals 0
  # EDGE case: "5."
end

def int_or_float?(num)
  return num.to_f if num.include?(".")
  return num.to_i
end

def operation_to_message(op)
  result = case op
           when "1"
            "Adding"
           when "2"
             "Subtracting"
           when "3"
             "Multipying"
           when "4"
             "Dividing"
           end

  puts "Random code"
  result
end

#byebug
prompt(MESSAGES["welcome"])
prompt(MESSAGES["name"])
name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(MESSAGES["incorrect_name"])
  else
    break
  end
end

prompt(TEST["greeting_with_name"])

loop do
  number1 = ''
  loop do
    prompt(MESSAGES[first_number])
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      number1 = int_or_float?(number1)
      break
    else
      prompt(MESSAGES[wrong_number])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES[second_number])
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      number2 = int_or_float?(number2)
      break
    else
      prompt(MESSAGES[wrong_number])
    end
  end

  prompt(MESSAGES["operator_prompt"])

  operator = nil
  loop do
    operator = Kernel.gets().chomp()

    if %w[1 2 3 4].include?(operator)
      break
    else
      prompt(MESSAGES["wrong_operator_input"])
    end
  end

  prompt(MESSAGES["operation_to_message"])

  result = case operator
           when "1"
             number1 + number2
           when "2"
             number1 - number2
           when "3"
             number1 * number2
           when "4"
             number1 / number2
           else
             raise "Please restart and enter the input for a valid operation."
           end

  prompt(MESSAGES["result"])
  # result's valid because ifs are **within the program's normal execution**

  prompt(MESSAGES["continue_or_end"])
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES["goodbye"])
