require "yaml"

LANGUAGE = "en"
MESSAGES = YAML.load_file("messages.yml")
NUMBERS = %w(0 1 2 3 4 5 6 7 8 9 _ % .)

def prompt(message)
  puts "=> #{message}"
end

def messages(message, lang=LANGUAGE)
  MESSAGES[lang][message]
end

def valid_number?(num)
  !num.empty? && !num.start_with?("%") &&
    num.split("").all? { |digit| NUMBERS.include?(digit) }
end

def correct_decimal(decimal)
  "0" + decimal
end

def percentage_to_decimal(num)
  (".0" + num[0, num.length - 1]).to_f
end

def decimal_to_percentage(num)
  "#{(num * 100).round(1)}%"
end

def retrieve_name
  loop do
    name = gets.chomp
    break name if !name.empty? && !NUMBERS.include?(name[0])
    prompt messages("incorrect_name")
  end
end

def retrieve_loan
  amount_loan = loop do
    amount_loan = gets.chomp
    break amount_loan if valid_number?(amount_loan) && amount_loan.to_i != 0
    prompt messages("incorrect_number")
  end
  amount_loan.to_i
end

def retrieve_annual_or_monthly
  loop do
    annual_or_monthly = gets.chomp
    break annual_or_monthly if annual_or_monthly.downcase == "a" ||
                               annual_or_monthly.downcase == "m"
    prompt messages("incorrect_annual_or_monthly")
  end
end

def retrieve_interest(annual_or_monthly)
  interest = loop do
    interest = gets.chomp
    break interest if valid_number?(interest)
    prompt messages("incorrect_number")
  end

  interest = percentage_to_decimal(interest) if interest.include?("%")
  interest = interest.to_f

  return interest / 12 if annual_or_monthly.downcase == "a"
  interest
end

def retrieve_months
  loop do
    duration_months = gets.chomp
    break duration_months.to_i if valid_number?(duration_months)
    prompt messages("incorrect_number")
  end
end

def confirm_details(amount_loan, interest_monthly, duration_months)
  prompt format(messages("confirm_details"),
                amount_loan: amount_loan,
                interest_monthly: decimal_to_percentage(interest_monthly),
                interest_annual: decimal_to_percentage(interest_monthly * 12),
                duration_months: duration_months)
end

def calculate_payment(amount_loan, interest_monthly, duration_months)
  (amount_loan * (interest_monthly /
                    (1 - (1 + interest_monthly)**-duration_months))).round(2)
end

def new_calculation?
  prompt messages("repeat?")
  gets.chomp.downcase
end

def clean_terminal
  system("clear") || system("cls")
end

duration_months = ""
amount_loan = ""
annual_or_monthly = ""
interest_monthly = ""

clean_terminal

prompt messages("welcome")
prompt messages("ask_name")

name = retrieve_name

prompt format(messages("greeting_name"), name: name)
prompt messages("purpose")

loop do
  loop do
    prompt messages("amount_loan")
    amount_loan = retrieve_loan

    prompt messages("annual_or_monthly")
    annual_or_monthly = retrieve_annual_or_monthly

    prompt messages("interest_rate")
    interest_monthly = retrieve_interest(annual_or_monthly)

    prompt messages("duration_months")
    duration_months = retrieve_months

    confirm_details(amount_loan, interest_monthly, duration_months)

    confirm = gets.chomp.downcase
    break if confirm != "n"
  end

  payment_monthly = calculate_payment(amount_loan, interest_monthly,
                                      duration_months)
  prompt format(messages("monthly_payment"), payment_monthly: payment_monthly)

  break if new_calculation? != "y"
  clean_terminal
end

prompt format(messages("goodbye"), name: name)
