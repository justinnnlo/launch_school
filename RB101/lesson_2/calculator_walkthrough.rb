# Ask the user for 2 numbers
# Ask the user for an operation to perform
# Perform the operation on the 2 numbers
# Output the result

# Note: this is a simpler approach to the calculator I previously made

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op)
  case op
  when "1"
    "Adding"
  when "2"
    "Subtracting"
  when "3"
    "Multipying"
  when "4"
    "Dividing"
  end
end

prompt("Welcome to the Calculator!")
prompt("What's your name?")
name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt('Make sure you use a valid name.')
  else
    break
  end
end

prompt("Hi, #{name}!")

loop do
  number1 = ''
  loop do
    prompt("What's the first number?")
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      break
    else
      prompt('It\'s wrong...')
    end
  end

  number2 = ''
  loop do
    prompt("What's the second number?")
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt('It\'s wrong...')
    end
  end

  operator_prompt = <<-MSG
  What operations would you like to perform?
  1. Add
  2. Substract
  3. Multiply
  4. Divide
  MSG
  prompt(operator_prompt)

  operator = nil
  loop do
    operator = Kernel.gets().chomp()

    if %w[1 2 3 4].include?(operator)
      break
    else
      prompt('You must choose 1, 2, 3 or 4')
    end
  end

  prompt("#{operation_to_message(operator)} the 2 numbers...")

  result = case operator
           when "1"
             number1.to_i() + number2.to_i()
           when "2"
             number1.to_i() - number2.to_i()
           when "3"
             number1.to_i() * number2.to_i()
           when "4"
             number1.to_f() / number2.to_f()
           else
             raise "Please restart and enter the input for a valid operation."
           end

  prompt("The result is #{result}")
  # result's valid because ifs are **within the program's normal execution**

  prompt('Do you want to perform another calculation? (Y to calculate again.)')
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt('Thanks for using the calculator!')
