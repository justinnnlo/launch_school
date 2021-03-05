require "byebug"

class Move
  attr_reader :value

  VALUES = ["rock", "paper", "scissors", "spock", "lizard"]
  WINNING_COMBINATIONS = {
    "rock" => ["scissors", "lizard"],
    "paper" => ["rock", "spock"],
    "scissors" => ["paper", "lizard"],
    "spock" => ["scissors", "rock"],
    "lizard" => ["spock", "paper"]
  }

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == "scissors"
  end

  def paper?
    @value == "paper"
  end

  def rock?
    @value == "rock"
  end

  def lizard?
    @value == "lizard"
  end

  def spock?
    @value == "spock"
  end

  def >(other_value)
    WINNING_COMBINATIONS[value].include? other_value.value
  end

  def <(other_value)
    WINNING_COMBINATIONS[other_value.value].include? value
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp.strip # n makes clearer this isn't the instance variable
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, spock or lizard:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice. Please enter one of: #{Moves::VALUES.join}"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game orchestration engine
class RPSGame
  attr_accessor :human, :computer

  WINNING_POINTS = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_message

    loop do
      human.score = 0
      computer.score = 0

      play_tournament

      display_tournament_winner
      break unless play_again?
    end

    display_goodbye_message
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp

      break if ["y", "n"].include? answer.downcase
      puts "Sorry, must be y or n"
    end

    answer.downcase == "y"
  end

  def play_tournament
    loop do
      player_choices
      display_moves
      result = compare_moves
      add_score(result)
      display_round_result(result)
      display_score
      break if human.score == WINNING_POINTS || computer.score == WINNING_POINTS
    end
  end

  def player_choices
    human.choose
    computer.choose
    clear_screen
  end

  def display_moves
    # Access to human and computer instance variables as within RPSGame class
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def compare_moves
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    else
      :tie
    end
  end

  def display_round_result(result)
    puts
    if result == human
      puts "#{human.name} won!"
    elsif result == computer
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def add_score(player)
    player.score += 1 unless player == :tie
  end

  def display_score
    puts "#{human.name} has #{human.score}"
    puts "#{computer.name} has #{computer.score}"
    puts
  end

  def display_tournament_winner
    if human.score == WINNING_POINTS
      puts "#{human.name} won the tournament!"
    elsif computer.score == WINNING_POINTS
      puts "#{computer.name} won the tournament!"
    end
  end

  def display_welcome_message
    puts "Welcome to Rock, Papers, Scissors, Spock, Lizard!"
  end

  def display_goodbye_message
    clear_screen
    puts "Thanks for playing Rock, Papers, Scissors, Spock, Lizard!"
  end
end

def clear_screen
  system("cls") || system("clear")
end

clear_screen
RPSGame.new.play
