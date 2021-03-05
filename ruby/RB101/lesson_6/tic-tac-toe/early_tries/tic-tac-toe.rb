require "byebug"
require "yaml"

MESSAGES = YAML.load_file("messages.yml") # Missed "_file"

LEGAL_MOVES = [:U, :C]

def valid_move?(move)
end

def computer_move(board)
  row, column = nil
  loop do
    row = rand(0..2)
    column = rand(0..2)
    break if board[row][column] == ""
  end

  board[row][column] = :C
end

def board_move(row, column, board)
  board[row][column] = :U
end

def all_equal?(*array)
  return false if array.length == 0
  array.flatten.uniq.length == 1
end

def win?(board)
  all_equal?(board[0][0,3]) || all_equal?(board[1][0,3]) || all_equal?(board[2][0,3]) ||
  all_equal?(board[0][0], board[1][1], board[2][2]) ||
  all_equal?(board[0][2], board[1][1], board[2][0]) ||
  all_equal?(board[0][0], board[1][0], board[2][0]) ||
  all_equal?(board[0][1], board[1][1], board[2][1]) ||
  all_equal?(board[0][2], board[1][2], board[2][2])
end

def print_board(board)
  board.each { |subarray| p subarray}
end

def print_message(message)
  puts MESSAGES[message]
end

def user_input_row
  print_message("row_move")
  row = gets.chomp
end

def user_input_column
  print_message("column_move")
  column = gets.chomp
end

def valid_input(row)
  row == row.to_i.to_s
end

print_message("welcome")

loop do
  board = [
    [:O, :O, :O],
    [:O, :O, :O],
    [:O, :O, :O]
  ]

  loop do
    print_board(board)

    loop do
      row = nil

      loop do
        row = user_input_row
        break if valid_input(row)
        print_message("wrong_input")
      end

      column = nil

      loop do
        column = user_input_column
        break if valid_input(column)
        print_message("wrong_input")
      end

      board[row.to_i][column.to_i] = :U if board[row.to_i][column.to_i] == :O
      break if board[row.to_i][column.to_i] == :U
      print_message("invalid_location")
    end
    break if win?(board)

    computer_move(board)
    break if win?(board)
  end

  print_message("winner")
end



