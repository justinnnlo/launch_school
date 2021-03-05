def display_board(brd)
puts ""
puts "     |     |"
puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
puts "     |     |"
puts "—----+—----+—----"
puts "     |     |"
puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
puts "     |     |"
puts "—----+—----+—----"
puts "     |     |"
puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
puts "     |     |"
puts ""
end

def initialize_board
  new_board = {}
  (1..9).each {|num| new_board[num] = " "}
  new_board
end

board = initialize_board
display_board(board)

# Player turn

def prompt(message)
  puts ">> #{message}"
end

def empty_squares(brd)
  brd.keys.select{|num| brd[num] == " "}
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (1-9):"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break
    else
      prompt "Sorry, that's not a valid choice"
    end
  end

    brd[square] = "X"
end

player_places_piece!(board)
puts board.inspect
display_board(board)