VALID_CHOICES = %w(rock paper scissors)

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  elsif player == computer
    prompt("It's a tie!")
  end
end

def win?(first, second)
  (first == "rock" and second == "scissors") or
    (first == "paper" and second == "rock") or
    (first == "scissors" and second == "paper")
end

# Insights: you can call a method you still haven't defined...
# as long as it's defined BEFORE you first call it

def prompt(message)
  Kernel.puts("=> #{message}")
end

loop do
  choice = ""
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose #{choice} and the computer chose #{computer_choice}")

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?("y")
end
