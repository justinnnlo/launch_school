require 'yaml'

VALID_CHOICES = %w(rock paper scissors spock lizard)
DISPLAY_VALID_CHOICES = %w(rock\ (r) paper\ (p) scissors\ (s)
                           spock\ (S) lizard\ (l))
MESSAGES = YAML.load_file("messages.yml")
WIN = {
  "rock" => ["scissors", "lizard"],
  "scissors" => ["paper", "lizard"],
  "paper" => ["rock", "spock"],
  "lizard" => ["paper", "spock"],
  "spock" => ["rock", "scissors"]
}

def display_results(player, computer)
  if win?(player, computer)
    puts MESSAGES["win"]
  elsif win?(computer, player)
    puts MESSAGES["lose"]
  elsif player == computer
    puts MESSAGES["tie"]
  end
end

def win?(first, second)
  WIN[first].include?(second)
end

def choice_translator(choice)
  return "rock" if choice == "r"
  return "scissors" if choice == "s"
  return "paper" if choice == "p"
  return "lizard" if choice == "l"
  return "spock" if choice == "S"
end

def declare_winner(player_wins, computer_wins)
  if player_wins > computer_wins
    puts format(MESSAGES["win_round"],
                player_wins: player_wins,
                computer_wins: computer_wins)
  else
    puts format(MESSAGES["win_round"],
                player_wins: player_wins,
                computer_wins: computer_wins)
  end
end

def clear_screen
  system("cls") || system("clear")
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

loop do
  clear_screen

  player_wins = 0
  computer_wins = 0
  choice = ""

  loop do
    loop do
      prompt "Choose one: #{DISPLAY_VALID_CHOICES.join(', ')}"

      choice = Kernel.gets().chomp()
      choice = choice_translator(choice) if choice.length == 1

      if VALID_CHOICES.include?(choice)
        break # break can't be a value returned by a method
      else
        puts MESSAGES["invalid_choice"]
      end
    end

    computer_choice = VALID_CHOICES.sample

    puts format(MESSAGES["choices"],
                choice: choice,
                computer_choice: computer_choice)

    display_results(choice, computer_choice)

    if choice == computer_choice
      next
    elsif win?(choice, computer_choice)
      player_wins += 1
    else
      computer_wins += 1
    end

    break if player_wins == 5 || computer_wins == 5
  end

  declare_winner(player_wins, computer_wins)

  prompt MESSAGES["play_again"]

  answer = Kernel.gets.chomp

  break unless answer.downcase.start_with?("y")
end
