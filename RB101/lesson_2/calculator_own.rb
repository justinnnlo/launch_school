=begin

Problem:
i) gets the 2 numbers,
ii) gets the operation to be performed,
iii) performs the operation on the 2 numbers and displays the result

Examples:

  "What's your first number?"
  4

  "What's your second numbers?"
  5

  "What do you want to do?"
  Add
    num_1 + num_2

  subtract
    num_1 - num_2
  multiply
    num_1 * num_2

  Divide
    return num_1 / num_2 if num_2 != 0
    raise "Your second number cannot be 0, please restart the program and try again."

  Data structures
  - All with strings, some integers and string interpolation

  Algorithms
  - Key detail:
    - Validating integers **are** integers and not strings.
    - Splitting the number and iterating through each digit does the trick.
  - Determining the operation to do via strings
=end

def number_input
  loop do                      # Loop until a valid number
    num = gets.chomp

    if integer_validation(num)
      num = num.to_i
      break num                # break otherwise returns nil
    end

    puts 'Please enter a valid integer'
  end
end

def integer_validation(string)
  numbers = %w[0 1 2 3 4 5 6 7 8 9]

  string.split('').all? { |ele| numbers.include?(ele) } ? true : false

  # By comparing strings we problems of string-to-integer conversion, which always equals 0
end

def operations
  puts 'What\'s your first number?'
  num1 = number_input

  puts 'What\'s your second number?'
  num2 = number_input

  loop do
    puts 'Do you want to add, subtract, multiply, or divide the 2 numbers?'
    operation = gets.chomp.downcase

    case operation
    when 'add'
      return num1 + num2
    when 'subtract'
      return num1 - num2
    when 'multiply'
      return num1 * num2
    when 'divide'
      return (num1 / num2).to_f unless num2.zero?

      raise 'The denominator cannot be 0. Please try again.'
    else
      puts "The operation was invalid. Please input 'add', 'subtract', 'multiply', or 'divide'.\n\n"
    end
  end
end

puts operations
