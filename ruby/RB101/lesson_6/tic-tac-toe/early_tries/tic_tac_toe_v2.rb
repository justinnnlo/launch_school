require "pry"
require "byebug"
require "yaml"

MESSAGES = YAML.load_file("messages.yml")
PLAYER_MARKER = :X
COMPUTER_MARKER = :O
WINNING_COMBINATIONS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
  [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
]

threats = []

WINNING_COMBINATIONS.each do |combination|
  threats << [[combination[0], combination[1]], combination[2]]
  threats << [[combination[1], combination[0]], combination[2]]
  threats << [[combination[2], combination[1]], combination[0]]
  threats << [[combination[1], combination[2]], combination[0]]
  threats << [[combination[0], combination[2]], combination[1]]
  threats << [[combination[2], combination[0]], combination[1]]
end

THREATENING_COMBINATIONS = threats

def clear_terminal
  system("clear") || system("cls")
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

def initialize_board
  board = {}
  (1..9).each { |num| board[num] = " " }
  board
end

def player_move!(board)
  loop do
    display_board(board)
    prompt(MESSAGES["player_move"])
    player_move = gets.chomp.to_i
    if board[player_move] == " "
      board[player_move] = PLAYER_MARKER
      break
    end
    prompt(MESSAGES["wrong_input"])
  end
end

def identify_threats(board)
  player_positions = board.select { |key, _| board[key] == :X }.keys
  combinations = player_positions.combination(2).to_a
  potential_moves = []

  THREATENING_COMBINATIONS.each do |subarray|
    combinations.each { |array| potential_moves << subarray[1] if array == subarray[0] }
  end
  potential_moves
end

def computer_move!(board)
  threats = identify_threats(board)
  threats.reject! { |ele| board[ele] == :O}

  if threats.length == 0
    move = board.select { |key, _| board[key] == " " }.keys.sample
  else
    loop do
      move = threats.sample
      break if board[move] == " "
    end
  end
  board[move] = COMPUTER_MARKER
  prompt format(MESSAGES["computer_move"], move: move)
end

def win?(marker, board)
  positions = board.select { |key, _| board[key] == marker }.keys
  position_combinations = positions.combination(3).to_a
  position_combinations.any? do |combination|
    WINNING_COMBINATIONS.include?(combination)
  end
end

def player_won_round?(board)
  win?(PLAYER_MARKER, board)
end

def computer_won_round?(board)
  win?(COMPUTER_MARKER, board)
end

def play_again?
  prompt(MESSAGES["replay?"])
  gets.chomp
end

def board_full?(board)
  if board.values.none? { |value| value == " " }
    prompt MESSAGES["board_full"]
    return true
  else
    return false
  end
end

def player_won_game?(player_wins)
  if player_wins == 5
    prompt(MESSAGES["player_win_game"])
    return true
  end
end

def computer_won_game?(computer_wins)
  if computer_wins == 5
    prompt(MESSAGES["computer_win_game"])
    return true
  end
end

prompt(MESSAGES["welcome"])
prompt(MESSAGES["how_to_move"])

loop do
player_wins = 0
computer_wins = 0

  loop do
    clear_terminal
    board = initialize_board

    loop do

      player_move!(board)
      if player_won_round?(board) || board_full?(board)
        player_wins += 1 if win?(PLAYER_MARKER, board)
        break
      end

      computer_move!(board)
      if computer_won_round?(board) || board_full?(board)
        computer_wins += 1 if win?(COMPUTER_MARKER, board)
        break
      end

      clear_terminal
    end

    break if computer_won_game?(computer_wins) || player_won_game?(player_wins)
  end

  replay = play_again?
  break unless replay.downcase == "y"
end
