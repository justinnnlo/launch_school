require "yaml"

# === Constants ===

MESSAGES = YAML.load_file("messages.yml")
CARD_VALUES = {
  2 => 2,
  3 => 3,
  4 => 4,
  5 => 5,
  6 => 6,
  7 => 7,
  8 => 8,
  9 => 9,
  10 => 10,
  :jack => 10,
  :queen => 10,
  :king => 10,
  :ace => [1, 11]
}

# === Methods: deck ===

def initialize_deck
  { 2 => 4,
    3 => 4,
    4 => 4,
    5 => 4,
    6 => 4,
    7 => 4,
    8 => 4,
    9 => 4,
    10 => 4,
    :jack => 4,
    :queen => 4,
    :king => 4,
    :ace => 4 }
end

def deal_card(deck, hand)
  remaining_cards = deck.select { |key, _| deck[key] > 0 }.keys
  selected_card = remaining_cards.sample
  hand << selected_card
  deck[selected_card] -= 1
end

def deal_two_cards(deck, player, computer)
  deal_card(deck, player)
  deal_card(deck, computer)
  deal_card(deck, player)
  deal_card(deck, computer)
end

# === Methods: count ===

def count_points(hand)
  sum = 0
  if hand.include?(:ace)
    (1..hand.count(:ace)).each { |_| sum = add_ace(hand, sum) }
    sum
  else
    hand.inject(0) { |acc, card| acc + CARD_VALUES[card] }
  end
end

def add_ace(hand, sum)
  values = hand.map { |card| CARD_VALUES[card] }
  sum = values.inject(sum) do |acc, value|
    if sum > 0
      sum
    else
      value.class == Integer ? acc + value : acc + 0
    end
  end
  sum + (sum + 11 > 21 ? 1 : 11)
end

# === End game ===

def busted?(hand)
  count_points(hand) > 21
end

def player_busted?(hand)
  if busted?(hand)
    system_clear
    prompt(format(MESSAGES["busted"], participant: "You're"))
    puts ""
    true
  else
    false
  end
end

def computer_busted?(hand)
  if busted?(hand)
    system_clear
    prompt(format(MESSAGES["busted"], participant: "The computer's"))
    puts ""
    true
  else
    false
  end
end

def computer_wins(player_hand, computer_hand)
  system_clear
  prompt(format(MESSAGES["computer_win"],
                computer_points: count_points(computer_hand),
                player_points: count_points(player_hand)))
  puts ""
  :computer
end

def tie
  system_clear
  prompt(MESSAGES["tie"])
  puts ""
end

def player_wins(player_hand, computer_hand)
  system_clear
  prompt(format(MESSAGES["player_win"],
                computer_points: count_points(computer_hand),
                player_points: count_points(player_hand)))
  puts ""
  :player
end

def compare_hands(player_hand, computer_hand)
  case count_points(player_hand) <=> count_points(computer_hand)
  when -1
    computer_wins(player_hand, computer_hand)
  when 0
    tie
  when 1
    player_wins(player_hand, computer_hand)
  end
end

def announce_winner(player_wins, computer_wins)
  if player_wins == 5
    prompt(format(MESSAGES["champion"], winner: "You",
                                        player_wins: player_wins,
                                        computer_wins: computer_wins))
  else
    prompt(format(MESSAGES["champion"], winner: "The computer",
                                        player_wins: player_wins,
                                        computer_wins: computer_wins))
  end
end

# === General methods ===

def prompt(message)
  puts ">> " + message
end

def join_cards(player_hand)
  player_hand.join(", ")
end

def display_your_cards(player_hand, dealer_card)
  prompt(format(MESSAGES["hand"], points: count_points(player_hand),
                                  cards: join_cards(player_hand),
                                  dealer_card: dealer_card))
end

def system_clear
  system("clear") || system("cls")
end

def start_game
  system_clear

  prompt(MESSAGES["welcome"])
  start = gets.chomp

  system_clear

  if start.downcase == "rules"
    prompt(MESSAGES["rules"])
    gets
  end

  system_clear
end

def display_score(player, computer)
  prompt(format(MESSAGES["score"], player_points: player,
                                   computer_points: computer))
end

# === Methods: move ===

def player_move(deck, player_hand, dealer_card)
  loop do
    break if busted?(player_hand)
    move = get_user_input(player_hand, dealer_card)
    if move.downcase == "h" || move.downcase == "hit"
      deal_card(deck, player_hand)
    elsif move.downcase == "s" || move.downcase == "stay"
      break
    else
      system_clear
      prompt(MESSAGES["move_wrong_input"])
    end
  end
end

def get_user_input(player_hand, dealer_card)
  display_your_cards(player_hand, dealer_card)
  prompt(MESSAGES["move"])
  gets.chomp
end

def computer_move(deck, computer_hand)
  loop do
    deal_card(deck, computer_hand) if count_points(computer_hand) < 17
    break if count_points(computer_hand) >= 17
  end
end

# === Methods: core looping ===

def play_single_game(deck, wins, player_hand, computer_hand)
  display_score(wins[:player], wins[:computer])

  player_move(deck, player_hand, computer_hand[0])
  if player_busted?(player_hand)
    wins[:computer] += 1
    return
  end

  computer_move(deck, computer_hand)
  if computer_busted?(computer_hand)
    wins[:player] += 1
    return
  end

  winner = compare_hands(player_hand, computer_hand)
  wins[winner] += 1 if winner == :player || winner == :computer
end

def play_full_round(wins)
  loop do
    deck = initialize_deck
    player_hand = []
    computer_hand = []

    deal_two_cards(deck, player_hand, computer_hand)

    play_single_game(deck, wins, player_hand, computer_hand)

    break if wins[:computer] == 5 || wins[:player] == 5
  end
end

def play_game
  loop do
    wins = { player: 0, computer: 0 }

    play_full_round(wins)

    announce_winner(wins[:player], wins[:computer])
    break if play_again?
    system_clear
  end
end

def play_again?
  prompt(MESSAGES["replay?"])
  replay = gets.chomp
  true unless replay.downcase == "yes"
end

# === Core gameplay ===

start_game

play_game

prompt(MESSAGES["goodbye"])
