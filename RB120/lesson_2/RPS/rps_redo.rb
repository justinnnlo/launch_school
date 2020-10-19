require "byebug"
=begin
-
  RPS is a 2 player game. It's composed of rounds that result in a player winning or a tie. The game ends when one of the players has the number of wins necessary to end the tournament.

  At the start of the turn, each player chooses a move. The moves are then compared. If a player wins, his score increases by one.

  At the end of the round, we check if there's a tournament winner. If there isn't, we start another round and repeat until done.

  Classes:
  - Players
    - Computer
    - Human
  - Move
    - Rock
    - Paper
    - Scissor
    - Lizard
    - Spock
  - Game engine

  Methods and states:
  - Players
    - Initialize
      - Score of 0
    - Read and write score

  - Human
    - Move
      - Ask for input and validate input
      - Input should have its unique class
  - Computer
    - Move
      - Asign input randomly

  - Move
    - COmparison operators to determine winner/loser
      - When one wins, increase its score by 1

  - RPSLS
    - Initialize
      - when it wins  => use class names
      - when it loses => use class names

  - Game engine
    - welcome the user
    - Ask the user for input
    - Get the computer's input
    - Compare answers and determine winner
    - Announce winner
    - Game ended? If not, loop. If yes, announce winner
    - Play again?

=end

class Player
  attr_accessor :score, :move
  attr_writer :move

  def initialize
    @score = 0
  end
end

class Human < Player

  def choose_move
    mv = nil

    loop do
      puts "Choose your move: #{GameEngine::VALUES.keys.join(', ')}"
      mv = gets.chomp.strip
      break if GameEngine::VALUES.keys.include? mv
      puts "Incorrect input. Please enter one of: #{GameEngine::VALUES.keys.join(', ')}"
    end

    @move = GameEngine::VALUES[mv]
  end

end

class Computer < Player
  def choose_move
    @move = GameEngine::VALUES.values.sample
  end
end

class Move
  attr_reader :win, :lose

  def <(other)
    lose.include? other.class
  end

  def >(other)
    win.include? other.class
  end
end

class Rock < Move
  def initialize
    @win = [Lizard, Scissors]
    @lose = [Spock, Paper]
  end
end

class Paper < Move
  def initialize
    @win = [Rock, Spock]
    @lose = [Lizard, Scissors]
  end
end

class Scissors < Move
  def initialize
    @win = [Paper, Lizard]
    @lose = [Spock, Rock]
  end
end

class Lizard < Move
  def initialize
    @win = [Spock, Paper]
    @lose = [Rock, Scissors]
  end
end

class Spock < Move
  def initialize
    @win = [Scissors, Rock]
    @lose = [Lizard, Paper]
  end
end

class GameEngine
  attr_accessor :human, :computer
  WINS_NEEDED = 3
  VALUES = { "rock" => Rock.new, "paper" => Paper.new, "scissor" => Scissors.new, "spock" => Spock.new, "lizard" => Lizard.new }

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def welcome
    puts "Welcome to a game of RPSLS!\n"
  end

  def display_round_winner(result)
    puts "You won!\n" if result == "human"
    puts "The computer won!\n" if result == "computer"
    puts "You tied\n" if result == "tie"
    puts "The scoreboard is: #{human.score} points for you and #{computer.score} for the computer."
  end

  def display_tournament_winner
  end

  def play_again?
    loop do
      puts "Do you want to play again (y/n)?"
      choice = gets.chomp.downcase
      return choice if choice == "y" || choice == "n"
      puts "Invalid input."
    end
  end

  def comparison_result
    return "human" if human.move > computer.move
    return "computer" if human.move < computer.move
    "tie"
  end

  def add_score(result)
    human.score += 1 if result == "human"
    computer.score += 1 if result == "computer"
  end

  def goodbye
    puts "Thanks for playing!"
  end

  def reset_wins
    human.score = 0
    computer.score = 0
  end

  def play
    welcome
    loop do
      reset_wins
      loop do
        human.choose_move
        computer.choose_move
        byebug
        result = comparison_result
        add_score(result)
        display_round_winner(result)
        break if human.score == WINS_NEEDED || computer.score == WINS_NEEDED
      end
      break unless play_again? == "y"
    end
    goodbye
  end
end

def clear_window
  system("cls") || system("clean")
end

clear_window
GameEngine.new.play

# class Rock
#   def initialize
#     @win = ["lizard", "scissors"]
#     @lose = ["spock", "paper"]
#   end
# end

# class Paper
#   def initialize
#     @win = ["rock", "spock"]
#     @lose = ["lizard", "scissors"]
#   end
# end

# class Scissors
#   def initialize
#     @win = ["paper", "lizard"]
#     @lose = ["spock", "rock"]
#   end
# end

# class Lizard
#   def initialize
#     @win = ["spock", "paper"]
#     @lose = ["rock", "scissors"]
#   end
# end

# class Spock
#   def initialize
#     @win = ["scissors", "rock"]
#     @lose = ["lizard", "paper"]
#   end
# end