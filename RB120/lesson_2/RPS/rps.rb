require "byebug"
# class Player
#   attr_accessor :move, :name

#   def initialize(player_type = :human)
#     @player_type = player_type
#     @move = nil
#     set_name
#   end

#   def set_name
#     if human?
#       n = nil
#       loop do
#         puts "What's your name?"
#         n = gets.chomp # n makes it clearer this isn't the instance variable
#         break unless n.empty?
#         puts "Sorry, must enter a value"
#       end
#       self.name = n
#     else
#       self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
#     end
#   end

#   def choose
#     if human?
#       choice = nil
#       loop do
#         puts "Please choose rock, paper or scissors:"
#         choice = gets.chomp
#         break if ["rock", "paper", "scissors"].include? choice
#         puts "Sorry, invalid choice."
#       end
#       self.move = choice
#     else
#       self.move = ["rock", "paper", "scissors"].sample
#     end
#   end

#   def human?
#     @player_type == :human
#   end
# end


class Move
  VALUES = ["rock", "paper", "scissors", "spock", "lizard"]

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
    case @value
    when "rock"     then true if other_value.scissors? || other_value.lizard?
    when "paper"    then true if other_value.rock? || other_value.spock?
    when "scissors" then true if other_value.paper? || other_value.lizard?
    when "spock"    then true if other_value.scissors? || other_value.rock?
    when "lizard"   then true if other_value.spock? || other_value.paper?
    else                 false
    end
  end

  def <(other_value)
    case @value
    when "rock"     then true if other_value.paper? || other_value.spock?
    when "paper"    then true if other_value.scissors? || other_value.lizard?
    when "scissors" then true if other_value.rock? || other_value.spock?
    when "spock"    then true if other_value.paper? || other_value.lizard?
    when "lizard"   then true if other_value.rock? || other_value.scissors?
    else                 false
    end
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
      n = gets.chomp # n makes clearer this isn't the instance variable
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
      puts "Sorry, invalid choice. Please enter one of: #{Moves::VALUES.join(" ")}"
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
      human.score, computer.score = 0, 0

      loop do
        human.choose
        computer.choose
        clear_screen
        display_moves
        display_round_winner
        display_score
        break if human.score == WINNING_POINTS || computer.score == WINNING_POINTS
      end

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

  def display_moves
    # Access to human and computer instance variables as within RPSGame class
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_round_winner
    puts
    if human.move > computer.move
      human.score += 1
      puts "#{human.name} won!"
    elsif human.move < computer.move
      computer.score += 1
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name} has #{human.score} and #{computer.name} has #{computer.score}"
    puts
  end

  def display_tournament_winner
    if human.score == WINNING_POINTS
      puts "#{human.name} won the tournament! He was the first to reach #{WINNING_POINTS}."
    elsif computer.score == WINNING_POINTS
      puts "#{computer.name} won the tournament! He was the first to reach #{WINNING_POINTS}."
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
