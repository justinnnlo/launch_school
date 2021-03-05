# Rules of the game

- Start with a 52-card deck of the 4 suits: hearts, diamonds, clubs and spaced
  - Each suit has 13 values (2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace)
  - For cards 2-10, their value is the number on the card
  - Jack, queen and king are each worth 10
  - Ace has a variable value: it's either 1 or 10
    - When the hand is > 21 if ace has a value of 10: it thus has a value of 1
    - Otherwise: it has a value of 10
    - Examples of a hand with 3 cards:
      - 2, 10, ace: 12 + 11 = 23, so ace is worth 1 and the hand is 2 + 10 +1 = 13
      - jack, queen, ace: 10 + 10 + 1 = 21
      - 7 + 3 + ace: 10 + 11 = 21, so ace is 21
- Objective: get as close to 21 as possible without going over
  - If you go over 21, you "bust" and lose
- Setup
  - 2 participants: player and dealer
  - Each participant is dealt 2 cards at the start. The player can only see 1 of the dealer's cards.
- Gameplay
  - The player starts and can decide to "hit" or "stay"
    - "Hit": the player will ask for another card
      - If he now has > 21 in his hand, he goes bust and the dealer wins
    - The turn is over when the player goes bust or he chooses to "stay"
  - The dealer's turn starts when the player stays
    - If the dealer has a hand worth 17 or more, he stays
    - Otherwise, he hits unstil he reaces at least 17 or goes bust
  - If the dealer also stays, the cards are revealed and compared. The one closest to 21 wins.

# Data structures
1. Deck: hash with arrays with i) integer values and ii) remaining values
  - Ace: 2 values in an array

card_values = {
  2 => 2,
  3 => 3,
  4 => 4,
  5 => 5,
  6 => 6,
  7 => 7,
  8 => 8,
  9 => 9,
  10 => 4,
  jack: 10,
  queen: 10,
  king: 10,
  ace: [1, 11]
}

deck = {
  2 => 4,
  3 => 4,
  4 => 4,
  5 => 4,
  6 => 4,
  7 => 4,
  8 => 4,
  9 => 4,
  10 => 4,
  jack: 4,
  queen: 4,
  king: 4,
  ace: 4
}

2. Hands: array
  - Dealer's first card is revealed

# Algorithms

- "Hit": add a random card to someone's hand and subtract it from the cards in the deck
  1. Add a random card
    - remaining_cards = deck.select { |key, value| deck[key] > 0 }.keys
    - selected_card = remaining_cards.sample
    - player_hand << selected_card
  2. Update the cards in the deck
    - deck[selected_card] -= 1

- Deal cards

- Calculate value in hand
  - Example hand: [2, 5, 10, :ace]
    - If hand.include?(:ace) != true
      hand.inject(0) { |acc, card| card_values[card] }
    - Else
      - value_hand = hand.map { |card| card_values[card] }
      - ...

- Core looping gameplay
  - Player should choose: hit or stay?
    - If hit: new card
      - Calculate the value of his hand
        - Bust? If so: end game and announce winner
        - Not bust? if so, repeat 1 — hit or stay?
    - If stay: go to dealer
  - Dealer
    - If hand >= 17: stay
    - Else: hit
      - Calculate the value of his hand
        - Bust? If so: end game
        - Not bust? if so, repeat 1 — hit or stay?
  - Comparison: when both stay
    - Compare the value of both of their hands
      - Announce as winner the largest hand or tie
        - Why
          - Everytime they hit a method would check if he went bust
          - Thus, as bust lilelihood is 0% we only need to check which is larger
          - Method to use: <=> operator because it also tells use if there is a tie

# Code

1. Initiate the deck
2. Deal cards
3. Player: hit or stay?
4. If hit: draw card and check if bust
5. If not bust, return to 2.
6. If bust, end game
7. If stay, it's the dealer's turn
8. Dealer: repeat logic of 2-5
9. If stay, compare both hands. The winner has the hand with most points
10. Play again?