require 'yaml'
MESSAGES = YAML.load_file('twenty_one.yml')

SUITS = { "C" => "Clubs", "D" => "Diamonds", "H" => "Hearts", "S" => "Spades" }
CARD_VALUE = ["K", "Q", "J", "10", "9", "8", "7", "6", "5", "4", "3", "2", "A"]

def messages(message)
  MESSAGES[message]
end

def prompt(msg)
  puts "=> #{msg}"
end

def newline
  puts ""
end

def initialize_deck
  CARD_VALUE.product(SUITS.keys).shuffle
end

def deal_cards!(deck, num)
  deck.shift(num)
end

# rubocop:disable Style/ConditionalAssignment
def tally(hand, n)
  values = hand.map { |card| card[0] }
  total = 0
  values.each do |value|
    if value == "A"
      total += 11
    elsif value =~ /[KQJ]/
      total += 10
    else
      total += value.to_i
    end
  end
  if total > n
    values.select { |value| value == "A" }.count.times { total -= 10 }
  end
  total
end
# rubocop:enable Style/ConditionalAssignment

def busted?(hand, n)
  hand > n
end

def display_cards(hand)
  hand.each do |card|
    puts "- #{card.first} of #{SUITS[card.last]}"
  end
end

def hit_or_stay(total, n)
  'stay' if (total >= (n - 4)) && (total <= n)
end

def display_winner(play_hand, deal_hand, score, n)
  if play_hand > n
    prompt(messages('you_bust'))
    score[:dealer] += 1
  elsif deal_hand > n
    prompt(messages('dealer_bust'))
    score[:player] += 1
  elsif deal_hand < play_hand
    prompt(messages('you_win'))
    score[:player] += 1
  elsif deal_hand > play_hand
    prompt(messages('dealer_win'))
    score[:dealer] += 1
  else
    prompt(messages('tie'))
  end
end

def display_score(score)
  prompt("score: you:#{score[:player]} dealer:#{score[:dealer]}")
end

def play_again?(choice)
  loop do
    newline
    prompt(messages('again?'))
    choice = gets.chomp.downcase
    break if valid?(choice, 'y', 'n')
  end
  choice
end

def valid?(choice, str1, str2)
  if [str1, str2].include?(choice)
    true
  else
    prompt("Sorry, please enter #{str1} or #{str2}")
  end
end

def display_end_of_round(play_hand, deal_hand, n)
  puts(messages('end_lines'))
  prompt(messages('dealer_final_dealt'))
  display_cards(deal_hand)
  prompt "Total: #{tally(deal_hand, n)}"
  newline
  prompt(messages('player_final_dealt'))
  display_cards(play_hand)
  prompt "Total: #{tally(play_hand, n)}"
  puts(messages('end_lines'))
end

def grand_winner?(scoreboard)
  if scoreboard[:dealer] == 5 || scoreboard[:player] == 5
    prompt(messages('grand_win'))
    display_grand_winner(scoreboard)
    scoreboard[:dealer] = 0
    scoreboard[:player] = 0
  end
end

def display_grand_winner(scoreboard)
  if scoreboard[:player] > scoreboard[:dealer]
    prompt "You!!!"
  elsif scoreboard[:player] < scoreboard[:dealer]
    prompt "Dealer!!!"
  end
end

def game_over(p_hand, d_hand, score, n)
  display_end_of_round(p_hand, d_hand, n)
  display_winner((tally(p_hand, n)), (tally(d_hand, n)), score, n)
  display_score(score)
  grand_winner?(score)
end

scoreboard = { player: 0, dealer: 0 }
n = 0

system 'clear'
prompt(messages('21_variation'))

loop do
  prompt(messages('valid_variation'))
  n = gets.chomp.to_i
  next unless (n >= 21) && (n <= 91)
  system 'clear'
  prompt "Welcome to #{n}!"

  deck = initialize_deck
  player_hand = deal_cards!(deck, 2)
  dealer_hand, unknown_card = deal_cards!(deck, 2)
  total_player = tally(player_hand, n)
  total_dealer = tally(dealer_hand, n)

  prompt(messages('dealer_dealt'))
  display_cards([dealer_hand])
  puts(messages('unknown'))
  newline
  prompt(messages('you_dealt'))
  display_cards(player_hand)
  prompt "which adds up to: #{total_player}"

  loop do
    newline
    prompt(messages('hit_stay'))
    answer = gets.chomp.downcase

    next unless valid?(answer, 'hit', 'stay')

    if answer.downcase == 'hit'
      player_hand += deal_cards!(deck, 1)
      prompt(messages('you_dealt'))
      display_cards(player_hand)
      prompt "which adds up to: #{total_player = tally(player_hand, n)}"
    end

    break if answer == 'stay' || busted?(total_player, n)
  end

  dealer_hand = [dealer_hand] + [unknown_card]
  choice = nil
  if busted?(total_player, n)
    game_over(player_hand, dealer_hand, scoreboard, n)
    play_again?(choice) == 'y' ? next : break
  end

  prompt(messages('you_stay'))
  newline
  prompt(messages('dealer_unknown'))

  loop do
    newline
    prompt(messages('dealer_dealt'))
    display_cards(dealer_hand)
    prompt "which adds up to: #{total_dealer = tally(dealer_hand, n)}"
    dealer_choice = hit_or_stay(total_dealer, n)
    break if dealer_choice == 'stay' || busted?(total_dealer, n)
    prompt(messages('dealer_hit'))
    dealer_hand += deal_cards!(deck, 1)
  end

  if busted?(total_dealer, n)
    game_over(player_hand, dealer_hand, scoreboard, n)
    play_again?(choice) == 'y' ? next : break
  end
  newline
  prompt(messages('dealer_stay'))

  game_over(player_hand, dealer_hand, scoreboard, n)
  play_again?(choice) == 'y' ? next : break
end
prompt "Thanks for playing #{n}! Goodbye!"
