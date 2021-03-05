require "yaml"

# === Constants ===

WINNING_COMBINATIONS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9],
  [1, 4, 7], [2, 5, 8], [3, 6, 9],
  [1, 5, 9], [3, 5, 7]
]

threats = []
WINNING_COMBINATIONS.each do |combination|
  threats << [[combination[0], combination[1]], combination[2]]
  threats << [[combination[1], combination[0]], combination[2]]
  threats << [[combination[2], combination[1]], combination[0]]
  threats << [[combination[1], combination[2]], combination[0]]
  threats << [[combination[2], combination[0]], combination[1]]
  threats << [[combination[0], combination[2]], combination[1]]
end

THREATENING_COMBINATIONS = threats
EMPTY_MARKER = " "
PLAYER_MARKER = :X
COMPUTER_MARKER = :C
MESSAGES = YAML.load_file("messages.yml")
FIRST_MOVER = "Choose"

# === General methods ===

def system_clear
  system("clear") || system("cls")
end

def print_message(message)
  prompt(MESSAGES[message])
end

def prompt(message)
  puts ">> #{message}"
end

def display_board(board)
  puts ""
  puts " #{board[1]} | #{board[2]} | #{board[3]} "
  puts "---+---+---"
  puts " #{board[4]} | #{board[5]} | #{board[6]} "
  puts "---+---+---"
  puts " #{board[7]} | #{board[8]} | #{board[9]} "
  puts ""
end

def empty_locations_hash(board)
  board.select { |key, _| board[key] == EMPTY_MARKER }
end

def joinor(board)
  array = empty_locations_hash(board).keys
  if array.length == 2
    array = array.insert(-2, "or").join(" ")
  elsif array.length > 2
    array = array.insert(-2, "or").join(", ")
    array[-3] = ""
  elsif array.length == 1
    return array[0]
  end

  array
end

def display_score(player_wins, computer_wins)
  puts format(MESSAGES["score"], player_wins: player_wins,
                                 computer_wins: computer_wins)
end

def initialize_board
  board = {}
  (1..9).each { |num| board[num] = EMPTY_MARKER }
  board
end

def choose_first_mover
  if FIRST_MOVER.downcase == "choose"
    print_message("first_mover")
    first_mover = gets.chomp
    return "player" if first_mover.downcase == "p" ||
                       first_mover.downcase == "player"
    "computer"
  else
    FIRST_MOVER
  end
end

# === Methods: moving ===

def valid_move?(move, board)
  empty_locations_hash(board).keys.include?(move)
end

def player_move!(board)
  loop do
    display_board(board)

    puts format(">> " + MESSAGES["player_move"], empty_locations: joinor(board))
    move = gets.chomp.to_i
    if valid_move?(move, board)
      board[move] = PLAYER_MARKER
      break
    end
    print_message("wrong_input")
  end
end

def computer_move!(board)
  move = if board[5] == EMPTY_MARKER
           5
         elsif computer_offense(board).empty? == false
           computer_offense(board).sample
         elsif computer_defense(board).length == 0
           computer_random_move(board)
         else
           computer_defense(board).sample
         end

  board[move] = COMPUTER_MARKER
end

def computer_random_move(board)
  array = empty_locations_hash(board).keys
  array.sample
end

def computer_defense(board)
  player_positions = board.select { |key, _| board[key] == PLAYER_MARKER }.keys
  player_combinations = player_positions.to_a.combination(2).to_a
  threats = []

  THREATENING_COMBINATIONS.each do |subarray|
    player_combinations.each do |combination|
      threats << subarray[1] if subarray[0] == combination
    end
  end

  threats.reject { |key| board[key] != EMPTY_MARKER }
end

def computer_offense(board)
  computer_positions = board.select do |key, _|
    board[key] == COMPUTER_MARKER
  end.keys.to_a
  computer_combinations = computer_positions.combination(2).to_a
  threats = []

  THREATENING_COMBINATIONS.each do |subarray|
    computer_combinations.each do |combination|
      threats << subarray[1] if subarray[0] == combination
    end
  end

  threats.reject { |key| board[key] != EMPTY_MARKER }
end

# === Methods: determining the winner ===

def win?(marker, board)
  positions = board.select { |key, _| board[key] == marker }.keys
  player_combinations = positions.combination(3).to_a
  WINNING_COMBINATIONS.any? do |subarray|
    player_combinations.any? { |combination| combination == subarray }
  end
end

def player_won?(board)
  if win?(PLAYER_MARKER, board)
    system_clear
    display_board(board)
    print_message("player_win_game")
    true
  else
    false
  end
end

def computer_won?(board)
  if win?(COMPUTER_MARKER, board)
    system_clear
    display_board(board)
    print_message("computer_win_game")
    true
  else
    false
  end
end

def board_full?(board)
  if empty_locations_hash(board).empty?
    system_clear
    display_board(board)
    print_message("board_full")
    true
  end
end

def announce_winner(player_wins, computer_wins)
  puts format(MESSAGES["winner"], winner: "you") if player_wins == 5
  puts format(MESSAGES["winner"], winner: "the computer") if computer_wins == 5
end

def game_with_player_starting(board)
  loop do
    player_move!(board)
    break if player_won?(board) || board_full?(board)

    computer_move!(board)
    break if computer_won?(board) || board_full?(board)
  end
end

def game_with_computer_starting(board)
  loop do
    computer_move!(board)
    break if computer_won?(board) || board_full?(board)

    player_move!(board)
    break if player_won?(board) || board_full?(board)
  end
end

def single_match(board, starting_player)
  if starting_player == "player"
    game_with_player_starting(board)
  else
    game_with_computer_starting(board)
  end
end

def play_full_round(starting_player)
  score = { computer_wins: 0, player_wins: 0 }

  loop do
    board = initialize_board

    single_match(board, starting_player)

    score[:player_wins] += 1 if player_won?(board)
    score[:computer_wins] += 1 if computer_won?(board)

    announce_winner(score[:player_wins], score[:computer_wins])
    break if score[:player_wins] == 5 || score[:computer_wins] == 5

    display_score(score[:player_wins], score[:computer_wins])
  end
end

def play_game
  loop do
    starting_player = choose_first_mover
    play_full_round(starting_player)

    print_message("replay?")
    break if gets.chomp.downcase != "y"
  end
end

# === Gameplay ===

system_clear
print_message("welcome")

play_game

print_message("goodbye")
