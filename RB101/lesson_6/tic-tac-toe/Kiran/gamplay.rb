require "yaml"
# require "pry"
# require "pry-byebug"

# rubocop:disable Security/YAMLLoad
############################# Constants #################################
LANGUAGE = "en"
CONFIG_MSG = YAML.load(File.read("ttt_config.yml"))
CONFIG_OPT_PATH = "ttt_option.yml"
SAVE_GAME_PATH = "ttt_save.yml"
SHORTCUTS = %w(score gp ss h s q c)
############################ Helper Functions ##########################
def prompt(*msg)
  puts "==> #{msg.join(' ')}"
end

def clear_screen
  system("clear") || system("cls")
end

def show_message(msg, lang = "en")
  CONFIG_MSG[lang][msg]
end

def valid_name?(name, _ = nil)
  (name.to_i == 0) && (name.length > 0) && (name.upcase != name.downcase)
end

def joinor(arr, sep = ", ", connector = "or")
  out_arr = arr.clone
  out_arr[-1] = connector + " " + out_arr[-1].to_s if arr.length > 1
  sep = " " if arr.length == 2
  out_arr.join(sep)
end

def get_current_leader(score)
  if score[NAME] > score["computer"]
    NAME.upcase
  elsif score[NAME] == score["computer"]
    "TIE"
  else
    "COMPUTER"
  end
end

def stringify_hash(hash)
  out_message_arr = []
  hash.each do |key, value|
    msg = "#{key.upcase} : #{value}"
    out_message_arr << msg
  end
  out_message_arr.join("\n")
end

def print_blank
  puts "\n"
end

############################## Listeners #################################
def quit(input, msg = nil)
  if input == "q"
    prompt msg unless msg.nil?
    true
  end
end

def clear(input, _)
  if input.downcase == "c"
    clear_screen
    false
  end
end

def quit_with_confirm(input, _msg = nil)
  if input == "q"
    input_msg = show_message(:quit)
    return_val = get_object_from_user(input_msg)
    return_val.downcase == "y" || return_val.downcase == "yes"
  end
end

def cancel_selection(input, _msg = nil)
  return true if input == "q"
end

def save_setting(input, setting)
  if input == "s"
    File.open(CONFIG_OPT_PATH, "w") { |file| file.write(setting.to_yaml) }
    true
  end
end

def help(input, msg = nil)
  if input == "h"
    if msg
      prompt msg
    else
      print_shortcut(false)
    end
    print_blank
    false
  end
end

def show_settings(input, settings)
  if input == "ss"
    prompt "Current Settings are \n #{stringify_setting(settings)} \n"
    false
  end
end

def show_game_params(input, game_parameters)
  if input == "gp"
    prompt "Current game parameters are \n#{stringify_hash(game_parameters)} \n"
    false
  end
end

def show_score(input, score)
  if input == "score"
    prompt "Current Score is \n#{stringify_hash(score)} \n"
    false
  end
end

############################## Getting Input From User ##################
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def get_object_from_user(input_msg, valid_fun = nil,
                         valid_message = nil, listeners = nil)
  valid_fun, valid_message, listeners =
    conv_2_array(valid_fun, valid_message, listeners)
  return_val = get_user_response(input_msg)
  listener_response, validity_response =
    get_listen_and_validity_response(return_val, listeners, valid_fun)
  while (listener_response == false) ||
        (!validity_response.nil? && listener_response.nil?)
    if !listener_response.nil?
      return_val = get_user_response(input_msg)
    else
      valid_msg_index = [valid_message.length - 1, validity_response].min
      return_val = get_user_response(valid_message[valid_msg_index])
    end
    listener_response, validity_response =
      get_listen_and_validity_response(return_val, listeners, valid_fun)
  end
  !listener_response ? return_val : listener_response
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def get_listen_and_validity_response(return_val, listeners, valid_fun)
  listener_response = check_for_listener(return_val, listeners)
  validity_response = check_for_validity(return_val, valid_fun)
  [listener_response, validity_response]
end

def get_user_response(msg)
  prompt msg
  gets.chomp
end

def conv_2_array(*obj)
  return_obj = obj.map do |curr_obj|
    if ((curr_obj.class == Array) && all_same_class?(curr_obj)) || curr_obj.nil?
      curr_obj
    else
      [curr_obj]
    end
  end
  return_obj
end

def all_same_class?(array)
  array.map(&:class).uniq.length == 1
end

def check_for_listener(input_val, listeners)
  return_val = nil
  return return_val if listeners.nil?
  listeners.each do |listener, listener_input|
    temp_val = method(listener).call(input_val, listener_input)
    return_val = temp_val if return_val.nil?
    return_val = temp_val if temp_val
  end
  return_val
end

def check_for_validity(input_val, valid_functs)
  return nil if valid_functs.nil?
  failure_func = valid_functs.detect do |func, func_input|
    !method(func).call(input_val, *func_input)
  end
  valid_functs.index(failure_func)
end

############################# GAME Functions #############################
############################# Initial Screen #############################
def start_game
  clear_screen
  display_welcome
  name = user_name
  quit_game = false
  [name, quit_game]
end

def user_name
  name_input_msg = show_message(:get_name)
  name_invalid_msg = show_message(:valid_name)
  get_object_from_user(name_input_msg, :valid_name?, name_invalid_msg)
end

### Initializing
def display_welcome
  prompt(show_message(:welcome))
end

def greet
  prompt(show_message(:greet), NAME.capitalize)
end

def valid_option?(value, _ = nil)
  (value.to_i.to_s == value) && (%w(1 2 3).include? value)
end

def option_from_user
  clear_screen
  greet
  option_input_msg = show_message(:choose_option)
  option_invalid_msg = show_message(:valid_option)
  listeners = [[:clear], [:quit, show_message(:thanks)]]
  get_object_from_user(option_input_msg, :valid_option?, option_invalid_msg,
                       listeners)
end

def user_menu_choice
  option = option_from_user
  quit_game = true if option == true
  [option, quit_game]
end

#################################### Initialize Game Setup#################
def setup_initial_board(marker)
  Array.new(3) { Array.new(3) { marker["initial"] } }
end

def get_marker_key(marker_setting_key)
  marker_setting_key.to_s.split("_")[-1]
end

def game_settings
  board_parameters = {}
  game_parameters = {}

  config_opt = YAML.load(File.read(CONFIG_OPT_PATH))
  board_keys = [:row_separator, :col_separator, :intersection_marker,
                :col_width, :row_height, :show_markers]
  marker_keys = [:marker_user, :marker_computer, :marker_initial]

  board_keys.each { |key| board_parameters[key] = config_opt[key] }
  marker = get_marker(marker_keys, config_opt)

  config_opt.keys.each do |key|
    game_parameters[key] = config_opt[key] unless (marker_keys.include? key) &&
                                                  (board_keys.include? key)
  end
  [board_parameters, game_parameters, marker]
end

def get_marker(marker_keys, config_opt)
  marker = {}
  marker_keys.each { |key| marker[get_marker_key(key)] = config_opt[key] }
  marker[NAME] = config_opt[:marker_user]
  marker.delete("user")
  marker
end

def new_score
  score = Hash.new
  score[NAME] = 0
  score["computer"] = 0
  score
end

def pp_score(score)
  prompt("Current Score is ", score.to_a.map { |x| x.join(" => ") }.join(" | "))
end

####################################### Display_Board ##########################
def display_board(board, board_parameters, marker)
  clear_screen
  display_markers(marker) if board_parameters[:show_markers] == "true"
  row_separator = board_parameters[:row_separator]
  col_separator = board_parameters[:col_separator]
  int_marker = board_parameters[:intersection_marker]
  col_width = board_parameters[:col_width]
  row_height = board_parameters[:row_height]

  empty_row = create_empty_row(col_separator, col_width)
  separator_row = create_sepator_row(row_separator, int_marker, col_width)

  3.times do |row_count|
    display_board_row(empty_row, board[row_count], col_separator,
                      row_height, col_width)
    prompt separator_row if row_count != 2
  end
end

def display_markers(marker)
  msg = "Computer => #{marker['computer']} | #{NAME} => #{marker[NAME]}"
  prompt msg + " \n"
end

def display_board_row(empty_row, row, col_separator, row_height, col_width)
  ((row_height - 1) / 2).times { prompt empty_row }
  prompt create_value_row(row, col_separator, col_width)
  ((row_height - 1) / 2).times { prompt empty_row }
end

def create_sepator_row(row_separator, int_marker, col_width)
  separator_cell = create_separator_cell(row_separator, col_width)
  separator_cell + int_marker + separator_cell + int_marker + separator_cell
end

def create_separator_cell(row_separator, col_width)
  row_separator * col_width
end

def create_empty_row(col_separator, col_width)
  empty_cell = " " * col_width
  empty_cell + col_separator + empty_cell + col_separator + empty_cell
end

def create_value_row(board_row, col_separator, col_width)
  cell0 = create_value_cell(board_row[0], col_width)
  cell1 = create_value_cell(board_row[1], col_width)
  cell2 = create_value_cell(board_row[2], col_width)
  cell0 + col_separator + cell1 + col_separator + cell2
end

def create_value_cell(value, col_width)
  half_width = (col_width - 1) / 2
  " " * half_width + value.to_s + " " * half_width
end

############################# GamePlay - Move #############################
def get_empty_squares(board, marker)
  empty_squares = []
  board.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      empty_squares << (3 * row_index + col_index + 1) if cell ==
                                                          marker["initial"]
    end
  end
  empty_squares
end

def get_user_move(empty_squares, game_parameters, score)
  input_msg = show_message(:user_move) + joinor(empty_squares)
  valid_msg = [show_message(:invalid_not_integer),
               show_message(:invalid_out_of_bounds),
               show_message(:invalid_already_chosen)]
  valid_fun = [[:valid_integer?], [:valid_square?],
               [:empty_square?, [empty_squares]]]
  listeners = [[:clear], [:show_game_params, game_parameters],
               [:show_score, score], [:quit_with_confirm], [:help]]
  get_object_from_user(input_msg, valid_fun, valid_msg, listeners)
end

def valid_integer?(num)
  num.to_i.to_s == num
end

def valid_square?(num)
  num.to_i.between?(1, 9)
end

def empty_square?(square, empty_squares)
  (empty_squares.include? square.to_i)
end

def conv_sq_to_address(square_no)
  row_no = (square_no - 1) / 3
  col_no = (square_no - 1) % 3
  [row_no, col_no]
end

def update_board(board, square, current_player, marker)
  current_marker = marker[current_player]
  row_no, col_no = conv_sq_to_address(square)
  board[row_no][col_no] = current_marker
end

def current_action(current_player, board, game_parameters,
                   marker, score)
  empty_squares = get_empty_squares(board, marker)
  quit_to_menu = false
  if current_player == NAME
    user_move = get_user_move(empty_squares, game_parameters, score)
    if user_move == true
      quit_to_menu = true
      user_move = nil
    end
    [user_move, quit_to_menu]
  else
    [get_computer_move(empty_squares, board, game_parameters, marker),
     quit_to_menu]
  end
end

def make_current_move(current_move, current_player, board, marker,
                      board_parameters)
  current_move = current_move.to_i
  update_board(board, current_move, current_player, marker)
  display_board(board, board_parameters, marker)
  display_current_move(current_player, current_move)
end

def round_over?(winner, empty_squares)
  winner || empty_squares.empty?
end

def update_round_state(board, current_move, current_player, marker)
  winner = current_player if won?(board, current_move, current_player, marker)
  empty_squares = get_empty_squares(board, marker)
  current_player = next_player(current_player) unless round_over?(winner,
                                                                  empty_squares)
  [winner, empty_squares, current_player]
end

def find_winning_square(board, empty_squares, current_player, marker)
  temp_board = board.map(&:clone)
  winning_squares = []
  empty_squares.each do |square|
    row_no, col_no = conv_sq_to_address(square)
    temp_board[row_no][col_no] = marker[current_player]
    winning_squares << square if won?(temp_board, square,
                                      current_player, marker)
    temp_board = board.map(&:clone)
  end
  winning_squares
end

def find_risky_square(board, empty_squares, current_player, marker)
  current_player = next_player(current_player)
  find_winning_square(board, empty_squares, current_player, marker)
end

############ GamePlay - AI ###################
def get_computer_move(empty_squares, board, game_parameters, marker)
  mode = game_parameters[:difficulty]
  case mode
  when "easy"
    get_computer_move_easy(empty_squares)
  when "medium"
    get_computer_move_medium(empty_squares, board, marker)
  when "hard"
    get_computer_move_hard(empty_squares, board, marker)
  when "hell"
    get_computer_move_hell(board, empty_squares, marker)
  end
end

def get_computer_move_easy(empty_squares)
  empty_squares.sample
end

def get_computer_move_medium(empty_squares, board, marker)
  risky_squares = find_risky_square(board, empty_squares, "computer", marker)
  return risky_squares.sample unless risky_squares.empty?
  empty_squares.sample
end

def get_computer_move_hard(empty_squares, board, marker)
  winning_squares = find_winning_square(board, empty_squares, "computer",
                                        marker)
  risky_squares = find_risky_square(board, empty_squares, "computer", marker)
  return winning_squares.sample unless winning_squares.empty?
  return risky_squares.sample unless risky_squares.empty?
  return 5 if empty_squares.include? 5
  empty_squares.sample
end

def get_computer_move_hell(board, empty_squares, marker)
  find_best_move(board, empty_squares, "computer", marker)
end

####### Min Max #########
def get_highest_score_move(move_score_hash)
  highest_score = move_score_hash.values.max
  move_score_hash.select { |_, value| value == highest_score }.keys.sample
end

def find_best_move(board, empty_squares, current_player, marker)
  move_score_hash = {}
  empty_squares.each do |square|
    temp_board = board.map(&:clone)
    update_board(temp_board, square, current_player, marker)
    move_score_hash[square] = calculate_best_result(temp_board,
                                                    next_player(current_player),
                                                    current_player, marker)
  end
  get_highest_score_move(move_score_hash)
end

def calculate_best_result(board, current_player, starting_player, marker)
  empty_squares = get_empty_squares(board, marker)
  winning_squares = find_winning_square(board, empty_squares, current_player,
                                        marker)
  return current_player == starting_player ? 1 : -1 if !winning_squares.empty?
  return 0 if empty_squares.length == 1
  all_move_result = empty_squares.map do |square|
    temp_board = board.map(&:clone)
    update_board(temp_board, square, current_player, marker)
    calculate_best_result(temp_board, next_player(current_player),
                          starting_player, marker)
  end
  current_player != starting_player ? all_move_result.min : all_move_result.max
end

############################# GamePlay - Overall #############################
def user_2_start?(game_parameters)
  (game_parameters[:who_starts] == "user") ||
    ((game_parameters[:who_starts] == "random") && user_wins_coin_toss)
end

def user_wins_coin_toss
  rand >= 0.5
end

def start_match
  score = new_score
  board_parameters, game_parameters, marker = game_settings
  quit_to_menu = false
  [score, board_parameters, game_parameters, marker, quit_to_menu]
end

def start_new_round(marker, game_parameters, board_parameters)
  board = setup_initial_board(marker)
  current_player = user_2_start?(game_parameters) ? NAME : "computer"
  winner = nil
  empty_squares = get_empty_squares(board, marker)
  display_board(board, board_parameters, marker)
  [board, current_player, winner, empty_squares]
end

def next_player(current_player)
  current_player == NAME ? "computer" : NAME
end

def display_current_move(current_player, current_move)
  prompt(current_player, show_message(:move_made), current_move)
end

def update_score(score, winner)
  score[winner] += 1 if winner
end

def display_match_result(winner, score)
  print_blank
  prompt winner ? "#{winner} wins" : "it's a tie"
  pp_score(score)
end

def update_match_result(score, winner, quit_to_menu)
  update_score(score, winner)
  display_match_result(winner, score) unless quit_to_menu
end

def grand_winner?(score, game_parameters)
  score.values.max >= game_parameters[:winner_cutoff]
end

def get_continue_answer(game_parameters, score)
  print_blank
  prompt(show_message(:winner_cutoff), game_parameters[:winner_cutoff].to_s)
  input_msg = show_message(:continue)
  valid_fun = :valid_reponse?
  listeners = [[:clear], [:show_game_params, game_parameters],
               [:show_score, score]]
  get_object_from_user(input_msg, valid_fun, input_msg, listeners)
end

def get_continue_answer_grand_winner(game_parameters, score)
  current_winner = get_current_leader(score)
  prompt(show_message(:grand_winner), current_winner.upcase)
  print_blank
  input_msg = show_message(:continue_grand_winner)
  valid_fun = :valid_reponse?
  listeners = [[:clear], [:show_game_params, game_parameters],
               [:show_score, score]]
  get_object_from_user(input_msg, valid_fun, input_msg, listeners)
end

def get_continue_from_user(score, game_parameters, quit_to_menu)
  return [score, quit_to_menu] if quit_to_menu
  print_blank
  if grand_winner?(score, game_parameters)
    response = get_continue_answer_grand_winner(game_parameters, score)
    score = new_score if play_again?(response)
  else
    response = get_continue_answer(game_parameters, score)
  end
  quit_to_menu = true unless play_again?(response)
  [score, quit_to_menu]
end

def valid_reponse?(response)
  ["yes", "y", "no", "n"].include? response.downcase
end

def play_again?(response)
  response.downcase!
  response == "y" || response == "yes"
end

def display_bye(score, game_parameters)
  current_winner = get_current_leader(score)
  if grand_winner?(score, game_parameters)
    if current_winner == NAME.upcase
      prompt(show_message(:thanks_game_win), NAME.capitalize)
    else
      prompt(show_message(:thanks_game_loss), NAME.capitalize)
    end
  else
    show_sendoff(current_winner)
  end
  sleep(1.5)
end

def show_sendoff(current_winner)
  sendoff = case current_winner
            when NAME.upcase
              show_message(:winner)
            when "COMPUTER"
              show_message(:loser)
            when "TIE"
              show_message(:tie)
            end
  prompt(sendoff, NAME.capitalize)
end

############################# Determine Winner #############################
def won?(board, move, current_player, marker)
  current_marker = marker[current_player]
  move = move.to_i
  row_no, col_no = conv_sq_to_address(move)
  return true if filled_row?(row_no, board, current_marker)
  return true if filled_column?(col_no, board, current_marker)
  return true if filled_diag_159?(board, current_marker)
  return true if filled_diag_357?(board, current_marker)
  false
end

def filled_row?(row_no, board, marker)
  board[row_no].uniq == [marker]
end

def filled_column?(col_no, board, marker)
  board.map { |sub_arr| sub_arr[col_no] }.uniq == [marker]
end

def filled_diag_159?(board, marker)
  [board[0][2], board[1][1], board[2][0]].uniq == [marker]
end

def filled_diag_357?(board, marker)
  [board[2][2], board[1][1], board[0][0]].uniq == [marker]
end

############################# Settings ##############################
def pp_settings(settings)
  out_message_arr = [show_message(:settings_welcome)]
  out_message_arr << stringify_setting(settings)
  out_message_arr << show_message(:settings_other_options)
  out_message_arr.join("\n")
end

def stringify_setting(settings)
  settings_keys = settings.keys
  out_message_arr = []
  settings_keys.each_with_index do |value, index|
    msg = "#{index + 1}) #{value.upcase} (Current Value : #{settings[value]})"
    out_message_arr << msg
  end
  out_message_arr.join("\n") + "\n"
end

def valid_setting?(choice, settings)
  setting_names = settings.keys
  (setting_names.include? choice.downcase.to_sym) ||
    ((setting_names[choice.to_i - 1]) && (choice.to_i.to_s == choice) &&
    (choice.to_i > 0))
end

def setting_from_user(settings)
  clear_screen
  input_msg = pp_settings(settings)
  valid_msg = show_message(:valid_setting)
  listeners = [[:save_setting, settings], [:cancel_selection], [:clear]]
  valid_fun = [:valid_setting?, [settings]]
  choice = get_object_from_user(input_msg, valid_fun, valid_msg, listeners)
  return choice if choice == true
  choice = choice.to_i == 0 ? choice.to_sym : settings.keys[choice.to_i - 1]
  prompt(show_message(:chosen_setting), choice.upcase)
  choice
end

def setting_to_update(config_opt)
  choice = setting_from_user(config_opt)
  quit_to_menu = choice == true
  [choice, quit_to_menu]
end

def load_config
  YAML.load(File.read(CONFIG_OPT_PATH))
end

def help_show_message(setting)
  msg_key = setting.to_s + "_help"
  show_message(msg_key.to_sym)
end

def updated_setting_value(current_settings, setting_to_update)
  clear_screen
  prompt help_show_message(setting_to_update)
  get_func = "get_#{setting_to_update}".to_sym
  listeners = [[:cancel_selection], [:clear],
               [:help, help_show_message(setting_to_update)],
               [:show_settings, current_settings]]
  method(get_func).call(current_settings, setting_to_update, listeners)
end

def update_settings(config_opt, choice)
  updated_choice_value = updated_setting_value(config_opt, choice)
  unless updated_choice_value == true
    update_settings_with_value(config_opt, choice, updated_choice_value)
  end
end

def update_settings_with_value(current_settings, setting_to_update, new_value)
  current_settings[setting_to_update] = new_value
end

################################ Individual Settings Code #############
####### Option with preset choices
def get_choice(_current_settings, setting_to_update, listeners, choices)
  input_msg = show_message(:update_setting) + setting_to_update.to_s
  valid_msg = show_message(:valid_choice) + joinor(choices)
  valid_fun = [[:valid_choice?, [choices]]]
  get_object_from_user(input_msg, valid_fun, valid_msg, listeners)
end

def get_difficulty(current_settings, setting_to_update, listeners)
  choices = ["easy", "medium", "hard", "hell"]
  get_choice(current_settings, setting_to_update, listeners, choices)
end

def get_who_starts(current_settings, setting_to_update, listeners)
  choices = ["user", "computer", "random"]
  get_choice(current_settings, setting_to_update, listeners, choices)
end

def get_show_markers(current_settings, setting_to_update, listeners)
  choices = ["true", "false"]
  get_choice(current_settings, setting_to_update, listeners, choices)
end

def valid_choice?(value, choices)
  choices.include? value.downcase
end

################ Numerical Setting #####################
def get_dim(_current_settings, setting_to_update, listeners)
  input_msg = show_message(:update_setting) + setting_to_update.to_s
  valid_msg = show_message(:valid_dim)
  valid_fun = :pos_odd?
  return_val = get_object_from_user(input_msg, valid_fun, valid_msg, listeners)
  return return_val.to_i if return_val != true
  return_val
end

def get_col_width(current_settings, setting_to_update, listeners)
  get_dim(current_settings, setting_to_update, listeners)
end

def get_row_height(current_settings, setting_to_update, listeners)
  get_dim(current_settings, setting_to_update, listeners)
end

def pos_odd?(num)
  num.to_i.to_s == num && num.to_i > 0 && num.to_i.odd?
end

def get_winner_cutoff(_current_settings, setting_to_update, listeners)
  input_msg = show_message(:update_setting) + setting_to_update.to_s
  valid_msg = show_message(:valid_cutoff)
  valid_fun = :pos?
  return_val = get_object_from_user(input_msg, valid_fun, valid_msg, listeners)
  return return_val.to_i if return_val != true
  return_val
end

def pos?(num)
  num.to_i.to_s == num && num.to_i > 0
end

############### Markers#####################
def get_board_marker(current_settings, setting_to_update, listeners)
  input_msg = show_message(:update_setting) + setting_to_update.to_s
  marker_invalid_msg = show_message(:valid_marker)
  marker_dup_msg = show_message(:duplicate_marker)
  valid_msg = [marker_invalid_msg, marker_dup_msg]
  valid_fun = [[:valid_separator?],
               [:unique_value?, [current_settings, setting_to_update]]]
  get_object_from_user(input_msg, valid_fun, valid_msg, listeners)
end

def get_row_separator(current_settings, setting_to_update, listeners)
  get_board_marker(current_settings, setting_to_update, listeners)
end

def get_col_separator(current_settings, setting_to_update, listeners)
  get_board_marker(current_settings, setting_to_update, listeners)
end

def get_intersection_marker(current_settings, setting_to_update, listeners)
  get_board_marker(current_settings, setting_to_update, listeners)
end

def get_marker_user(current_settings, setting_to_update, listeners)
  get_board_marker(current_settings, setting_to_update, listeners)
end

def get_marker_computer(current_settings, setting_to_update, listeners)
  get_board_marker(current_settings, setting_to_update, listeners)
end

def get_marker_initial(current_settings, setting_to_update, listeners)
  get_board_marker(current_settings, setting_to_update, listeners)
end

def valid_separator?(marker, _ = nil)
  marker.size == 1
end

def unique_value?(marker, current_settings, setting_to_update)
  current_marker_value = current_settings[setting_to_update]
  !(current_settings.values.include? marker) || (marker == current_marker_value)
end

############################# Codes for Shortcut keys################
def print_shortcut(get_feedback = true)
  prompt show_message(:shortcut_intro)
  print_blank
  SHORTCUTS.each { |key| prompt "#{key} => #{show_message(key + '_help')}" }
  user_response if get_feedback
end

def user_response
  input_msg = show_message(:shortcut_msg)
  valid_msg = show_message(:shortcut_msg)
  listeners = [[:clear], [:quit]]
  valid_fun = :always_invalid
  get_object_from_user(input_msg, valid_fun, valid_msg, listeners)
end

def always_invalid(_)
  false
end
############################# Main Code #############################
NAME, quit_game = start_game

until quit_game
  menu_option, quit_game = user_menu_choice
  case menu_option
  when "1"
    score, board_parameters, game_parameters, marker, quit_to_menu = start_match
    until quit_to_menu
      board, current_player, winner, empty_squares =
        start_new_round(marker, game_parameters, board_parameters)
      until round_over?(winner, empty_squares) || quit_to_menu
        current_move, quit_to_menu =
          current_action(current_player, board,
                         game_parameters, marker, score)
        if quit_to_menu != true
          make_current_move(current_move, current_player, board, marker,
                            board_parameters)
          winner, empty_squares, current_player =
            update_round_state(board, current_move, current_player, marker)
        end
      end
      update_match_result(score, winner, quit_to_menu)
      score, quit_to_menu = get_continue_from_user(score, game_parameters,
                                                   quit_to_menu)
    end
    display_bye(score, game_parameters)

  when "2"
    config_opt = load_config
    choice, quit_to_menu = setting_to_update(config_opt)
    until quit_to_menu
      update_settings(config_opt, choice)
      choice, quit_to_menu = setting_to_update(config_opt)
    end

  when "3"
    print_shortcut
  end
end
# rubocop:enable Security/YAMLLoad