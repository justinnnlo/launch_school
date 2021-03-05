# Description

Tic-Tac-Toe is a 2 player game. It's played on a 3x3 grid. Each player makes a move in their respective turn. In each turn, they decide where to place a marker.

The game ends when either player has 3 consecutive markers or when the board is full. Markers can be placed consecutively horizontally, vertically, or diagonally.

Class
- Player
  - Human
  - Computer
- Game engine
- Board
- Square

# Exploration

```ruby
class Board
  def initialize
    # A hash/array with each state?
    # State: Square object or a symbol/integer/string?
  end
end

class Square
  def initialize
    # status to keep track of its mark?
  end
end

class Player
  def initialize
    # Marker to keep track of the players' symbol?
  end
end

class Human < Player
  def initialize

  end
end

class Computer < Player
  def initialize

  end
end

class GameEngine
  def initialize
  end

  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = GameEngine.new
game.play # This starts the game
```