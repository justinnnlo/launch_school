# Problem
- 2 players compete: the human and computer
- 9 tile board
  - The board starts empty
  - In each turn, a player decides which tile to mark
  - Once a tile's been marked, the other player can't take it
- How to win
  - If a player is able to connect 3 tiles continuously horizontally, vertically or sideways they win
  - If the board is full and no player accomplished that, it's a tie

# High-level gameplay
1. The tile starts empty — DONE
2. The user starts by taking a tile
  - Create a loop
  - Ask for user input
  - Mutate board if correct, otherwise return to the previous step
  - Break loop
3. Has the player won?
4. If the game is not over, it's the turn of the other player to take a tile
5. Repeat step 3
6. If the player or the computer has won, does the user want to play again?
7. If yes, go back to 1
8. If no, end the program and output a farewell message

# Technical roadmap

## Data types
- Tile: 2-level nested arrays
- Within the arrays, it has one of 3 symbols
  - Tile not taken: :O
  - Tile taken by user: :U
  - Tile taken by computer: :C
- User input: string converted to symbol
- Computer input: random sample selector an available location (ie, with :O)
- Constants:
  - Legal moves
  - Winning combinations?

## Examples
```ruby
board = [
        [:O, :O, :O],
        [:O, :O, :O],
        [:O, :O, :O]
]

board[1][1] = :U # => need a method to validate that the input is correct
# => method that executes the computer's move
```

## Key subprocesses
1. Validate that a user's move is valid and execute it, otherwise ask for a new input
2. Choose from the remaining free tiles and execute the computer's move
3. Validate if someone has won after a turn

## Tentative methods
1. Validate if a user's move is valid
2. Randomly select a tile that still has a `:O` value
3. Mutate the board array with a valid player move
4. Confirm if someone has won and return a Boolean