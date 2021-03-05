require 'byebug'
require 'yaml'

LANGUAGE = "es"
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang=LANGUAGE)    # Instead of lang = "en"
  MESSAGES[lang][message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  numbers = %w[0 1 2 3 4 5 6 7 8 9 .]

  (num.split('').all? { |ele| numbers.include?(ele) } and num.empty? == false) ? true : false
  # EDGE cases: "5.", "1.", etc.
end

def int_or_float?(num)
  return num.to_f if num.include?(".")
  return num.to_i
end

def operation_to_message(op)
  result = case op
           when "1"
            messages("adding")
           when "2"
             messages("subtracting")
           when "3"
             messages("multipying")
           when "4"
             messages("dividing")
           end
end

prompt messages("welcome")
prompt messages("name")

name = ''
loop do
  name = Kernel.gets().chomp()
  break unless name.empty?()
  prompt messages("incorrect_name")
end

prompt format(messages("greeting_with_name"), name: name)

loop do
  number1 = ''
  loop do
    prompt messages("first_number")
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      number1 = int_or_float?(number1)
      break
    else
      prompt messages("wrong_number")
    end
  end

  number2 = ''
  loop do
    prompt messages("second_number")
    number2 = Kernel.gets().chomp()
    
    if valid_number?(number2)
      number2 = int_or_float?(number2)
      break
    else
      prompt messages("wrong_number")
    end
  end

  prompt messages("operator_prompt")

  operator = nil
  loop do
    operator = Kernel.gets().chomp()

    break if %w[1 2 3 4].include?(operator)
    prompt messages("wrong_operator_input")
  end

  prompt format(messages("operation_to_message"), message: operation_to_message(operator))

  result = case operator
           when "1"
             number1 + number2
           when "2"
             number1 - number2
           when "3"
             number1 * number2
           when "4"
             if number2.zero?
               messages("zero_denominator")
              else
                number1 / number2
              end
           else
             raise "Please restart and enter the input for a valid operation."
           end

  prompt format(messages("result"), result: result)
  # result's valid because ifs are **within the program's normal execution**

  prompt messages("continue_or_end")
  answer = Kernel.gets().chomp()
  break unless (answer.downcase.start_with?('y') if LANGUAGE == "en") or (answer.downcase.start_with?('s') if LANGUAGE == "es")
end

prompt messages("goodbye")
