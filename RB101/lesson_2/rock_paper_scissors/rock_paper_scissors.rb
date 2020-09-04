require "yaml"
require "byebug"

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

def display_results(winner, player_wins, computer_wins)
  if winner == "player"
    puts format(MESSAGES["win"], player_wins: player_wins, computer_wins: computer_wins)
  elsif winner == "computer"
    puts format(MESSAGES["lose"], player_wins: player_wins, computer_wins: computer_wins)
  else
    puts format(MESSAGES["tie"], player_wins: player_wins, computer_wins: computer_wins)
  end
end

def win?(first, second)
  return "tie" if first == second
  return "player" if WIN[first].include?(second)
  "computer"
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
    puts format(MESSAGES["lose_round"],
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

def input_choice
  loop do
    prompt "Choose one: #{DISPLAY_VALID_CHOICES.join(', ')}"

    choice = Kernel.gets().chomp()
    choice = choice_translator(choice) if choice.length == 1

    if VALID_CHOICES.include?(choice)
      return choice
    else
      puts MESSAGES["invalid_choice"]
    end
  end
end

loop do
  clear_screen

  player_wins = 0
  computer_wins = 0
  choice = ""

  loop do
    choice = input_choice

    computer_choice = VALID_CHOICES.sample

    puts format(MESSAGES["choices"],
                choice: choice,
                computer_choice: computer_choice)

    winner = win?(choice, computer_choice)

    player_wins += 1 if winner == "player"
    computer_wins += 1 if winner == "computer"

    display_results(winner, player_wins, computer_wins)

    break if player_wins == 5 || computer_wins == 5
  end

  declare_winner(player_wins, computer_wins)

  prompt MESSAGES["play_again"]

  answer = Kernel.gets.chomp

  break unless answer.downcase.start_with?("y")
end
