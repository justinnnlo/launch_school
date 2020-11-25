# Description

The deck has 13 different card values (2 to ace) of one of 4 suits (diamond, ace, YYY, ZZZ).

Each card is worth the same number of points as its number. Jacks, queens, and kings are each worth 10 points.The ace is worth 11 points if the sum of all the cards (and the 11 point ace) is worth 21 or less. Otherwise, the ace is worth 1 point

At the start of a round a new, complete, deck is shuffled. 2 cards are dealt to both the player and the dealer (i.e., the computer). The player can see his 2 cards and a single card of the computer (assumption: the first card dealt to it).

Each player can choose one of 2 actions: hit (ask for an additional card) or stay (play with the current cards). If a player ends with more than 21 points they go bust and lose.

If both players stay before going bust, we compare the sum of points in their hands. The one with the most points wins, unless there's a tie.

At the end of the round, if there's a winner add 1 point. The first player who gets to 5 points wins the game.

At the end of the game, ask the player if he wants to continue or end the game.

# Tentative classes
- Player
  - Human
  - Computer
- Game engine
- Deck
- Card
- Hand

## Attributes per class

- Player
  - Hand: hand object
  - Points: points held in the game so far
- Human
  - Move
- Computer
  - Move
- Game engine
  - Human player
  - Computer player
- Deck
  - Card values constant
  - Card suits constant
  - Deck attribute with all the cards
- Card — **how to deal with ace**? In a card method?
  - Value
  - Suit
- Hand
  - Cards: array that holds the card objects held by the player

## Methods per class

- Player
- Human
  - Move
  - Get user input
- Computer
  - Move
- Game engine
  - play game
  - play single game
  - play full round
  - display score
  - Deal 2 cards at the start of the game
  - Deal 1 card
  - Busted?
  - determine winner
  - Play again
  - prompt
- Deck
  - Initialize deck
- Card
  - Get points
  - Get suit
- Hand
  - Count points
    - How to count the value of the ace?
- Displayable module
  - display start game
  - display player busted
  - display computer busted
  - display player win
  - display computer win
  - display tie
  - display winner
  - system_clear
  - display your cards

# Exploration

```ruby
class Player
  def initialize
    @hand = Hand.new
  end
end

class Human < Player
end

class Computer < Player
end

module Displayable
end

class GameEngine
include Displayable
  def initialize
    @player = Player.new
    @computer = Computer.new
  end
end

class Deck
  VALUES =
  SUITS =
  def initialize
    @deck =
  end
end

class Card
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

class Hand
  def initialize
    @hand = []
  end
end

```