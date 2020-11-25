require "pry"
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |k| @squares[k].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

#==========
  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  # return winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.select { |k, _| line.include?(k) }.values) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  # Problem: return any marker if it's been used 3 consecutive times, else nil
  # Assumption: anything but space or nil is a marker
  #==========

  def reset
    (1..9).each { |key| @squares[key] = Square.new}
  end

  def draw
    puts "     |     |     "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]} "
    puts "     |     |     "
  end
end

class Square
  attr_accessor :marker
  INITIAL_MARKER = " "

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  private

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new # Represent state of board
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!\n"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!\n"
  end

  def clear
    system("clear") || system("cls")
  end

  def display_board
    puts "You're a #{human.marker}. The computer is a #{computer.marker}."
    puts ""
    board.draw # board.draw should only display the markers — it shouldn't know of player markers or paddings
               # Think of board.draw as the to_s for the board object — should be generic for wide use
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square: #{board.unmarked_keys.join(', ')}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end

    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result
    display_board
    case board.winning_marker
    when HUMAN_MARKER    then puts "You won!"
    when COMPUTER_MARKER then puts "Computer won!"
    else                 puts "The board is full!"
    end
  end


  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include? answer
      puts "Sorry, must be (y)es or (n)o"
    end

    answer[0] == "y"
  end

  def reset
    board.reset
    clear
  end

  def display_reset_message
    puts "Let's play again!"
    puts ""
  end

public
  def play
    display_welcome_message

    loop do
      display_board

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?

        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_reset_message
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play