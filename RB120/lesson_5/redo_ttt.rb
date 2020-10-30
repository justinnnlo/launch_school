=begin

TTT is a two player game. The game is played on a 3 x 3 board. The board starts empty.

In each turn a single player makes a move. A player moves by selecting a square in which to place a marker.

After a player moves in a square his marker is placed on it and will stay until the end of the game.

After the player has made his move, the game will end if the board is full or a player has 3 consecutive markers (laterally, horizontally or vertically).

Otherwise, the other player moves and the game continues.

When the game ends, ask the player if he wants to play again.

Classes
- Player
  - Human
    - Marker
    - Move
      - Select from available squares
  - Computer
    - Marker
    - Move
      - Move based on sample of avaiable squares
- GameEngine
  - Initialize: create and bind into instane variables a human, computer and board object
- Board
  - 3 x 3 array nested with square objects?
  - Empty squares
    - Return array of positions of unmarked squares
  - Print board
- Square
  - Initialize with a space
  - Get and set markers

=end

require "byebug"

class Player
  def marker
    self.class::MARKER
  end
end

class Human < Player
  MARKER = :X
end

class Computer < Player
  MARKER = :O

  def move
  end
end

class Board
  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |n| @squares[n] = Square.new }
  end

  def [](square)
    @squares[square]
  end

  def []=(square, marker)
    @squares[square].value = marker
  end

  def empty_squares
    @squares.select {|k,v| @squares[k].value == " " }.keys
  end

  def full?
    (1..9).all? { |n| @squares[n] != " " }
  end

  def display_board
    puts " #{@squares[1].to_s} | #{@squares[2].to_s} | #{@squares[3].to_s} "
    puts "---+---+---"
    puts " #{@squares[4].to_s} | #{@squares[5].to_s} | #{@squares[6].to_s} "
    puts "---+---+---"
    puts " #{@squares[7].to_s} | #{@squares[8].to_s} | #{@squares[9].to_s} "
  end
end

class Square
  attr_accessor :value
  def initialize
    @value = " "
  end

  def to_s
    @value
  end
end

module Display
  def display_welcome_message
    puts "Welcome to Tic-Tac-Toe!"
  end

  def display_goodbye
    puts "Thanks for playing and hope to see you soon!"
  end

  def display_ask_move
    puts "Choose a square to place the marker (#{@board.empty_squares.join(", ")}): "
  end
end

class GameEngine
  include Display
  attr_accessor :human, :computer, :board
  WINNING_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  def initialize
    @human = Human.new
    @computer = Computer.new
    @board = Board.new
  end

  def human_move
    square = nil
    loop do
      display_ask_move
      square = gets.chomp.to_i
      #byebug
      break if @board.empty_squares.include?(square)
      puts "Incorrect move, please enter a valid square"
    end

    @board[square] = @human.marker
  end

  def any_winner?
    


  def play
    display_welcome_message
    loop do
      board.reset
      loop do
        human_move
        break if any_winner? || board.full?

        computer_move
        break if any_winner? || board.full?
      end
      break unless play_again?
    end
    display_goodbye
  end
end

GameEngine.new.play