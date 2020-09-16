INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
MIDDLE_SQUARE = 5
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're an #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(array, comma=', ', conjunction='or')
  if array.length == 2
    array.join(" ").insert(-2, "#{conjunction} ")
  elsif array.length == 1
    array.join
  else
    array.join(comma).insert(-2, "#{conjunction} ")
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

def computer_places_piece!(brd)
  square = nil
  # offence first
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end
  # defence first
  if square.nil?
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if empty_squares(brd).include?(MIDDLE_SQUARE)
    square = MIDDLE_SQUARE
  end
  # just pick a square
  if square.nil?
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'You'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def update_score!(winner, scoreboard)
  if winner == 'You'
    scoreboard[:player] += 1
  elsif winner == 'Computer'
    scoreboard[:computer] += 1
  end
end

def display_score(scoreboard)
  prompt("score: you:#{scoreboard[:player]} computer:#{scoreboard[:computer]}")
end

def grand_winner?(scoreboard)
  if scoreboard[:computer] == 5 || scoreboard[:player] == 5
    prompt "Grand winner goes to..."
    display_grand_winner(scoreboard)
    scoreboard[:computer] = 0
    scoreboard[:player] = 0
  end
end

def display_grand_winner(scoreboard)
  if scoreboard[:player] > scoreboard[:computer]
    prompt "You!!!"
  elsif scoreboard[:player] < scoreboard[:computer]
    prompt "Computer!!!"
  end
end

def place_piece!(brd, nxt_trn)
  nxt_trn.even? ? player_places_piece!(brd) : computer_places_piece!(brd)
end

def detect_starting_opponent(nxt_trn, choice)
 if choice.downcase.start_with?('p')
   nxt_trn = 0
 elsif choice.downcase.start_with?('c')
   nxt_trn = 1
 else
   nxt_trn = [0, 1].sample
 end
end

def starting_opponent?(nxt_trn)
  prompt "Who should go first? (p)layer, (c)omputer or (r)andom"
  choice = gets.chomp
  detect_starting_opponent(nxt_trn, choice)
end

scoreboard = { player: 0, computer: 0 }

loop do
  board = initialize_board
  display_board(board)
  next_turn = starting_opponent?(next_turn)

  loop do
    display_board(board)
    place_piece!(board, next_turn)
    break if someone_won?(board) || board_full?(board)
    next_turn += 1
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "its a tie!"
  end

  update_score!(detect_winner(board), scoreboard)
  display_score(scoreboard)

  grand_winner?(scoreboard)

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
