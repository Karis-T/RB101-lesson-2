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

def tally(hand, n)
  values = hand.map { |card| card[0] }
  total = 0
  values.each do |value|
    total += if value == "A"
               11
             elsif value =~ /[KQJ]/
               10
             else
               value.to_i
             end
  end
  total = correct_for_aces(total, values, n)
end

def correct_for_aces(total, values, n)
  if total > n
    values.select { |value| value == "A" }.count.times { total -= 10 }
  end
  total
end

def busted?(hand, n)
  hand > n
end

def display_cards(hand)
  hand.each do |card|
    puts "- #{card.first} of #{SUITS[card.last]}"
  end
end

def dealer_hit_or_stay(total, n)
  'stay' if (total >= (n - 4)) && (total <= n)
end

def display_winner(play_hand, deal_hand, score, n)
  if play_hand > n
    prompt(messages('you_bust'))
    update_score(score, :dealer)
  elsif deal_hand > n
    prompt(messages('dealer_bust'))
    update_score(score, :player)
  elsif deal_hand < play_hand
    prompt(messages('you_win'))
    update_score(score, :player)
  elsif deal_hand > play_hand
    prompt(messages('dealer_win'))
    update_score(score, :dealer)
  else
    prompt(messages('tie'))
  end
end

def update_score(score, key)
  score[key] += 1
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

def detect_grand_winner(scoreboard)
  if scoreboard[:dealer] == 5 || scoreboard[:player] == 5
    prompt(messages('grand_win'))
    display_grand_winner(scoreboard)
    reset_scores(scoreboard)
  end
end

def reset_scores(scoreboard)
  scoreboard[:dealer] = 0
  scoreboard[:player] = 0
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
  detect_grand_winner(score)
end

def variation_valid?(n)
  (n >= 21) && (n <= 91) ? true : false
end

def choose_game_variation(n)
  loop do
    prompt(messages('valid_variation'))
    n = gets.chomp.to_i
    break if variation_valid?(n)
    prompt(messages('invalid_variation'))
  end
  n
end

def display_both_hands(p_hand, d_hand, p_total)
  prompt(messages('dealer_dealt'))
  display_cards([d_hand])
  puts(messages('unknown'))
  newline
  prompt(messages('you_dealt'))
  display_cards(p_hand)
  prompt "which adds up to: #{p_total}"
end

def player_turn(p_hand, p_total, n, deck)
  loop do
    newline
    prompt(messages('hit_stay'))
    answer = gets.chomp.downcase
    next unless valid?(answer, 'h', 's')
    if answer.downcase == 'h'
      p_total = player_hit(p_hand, n, deck)
    end
    break if answer == 's' || busted?(p_total, n)
  end
  p_total
end

def player_hit(p_hand, n, deck)
  p_hand << deal_cards!(deck, 1).flatten
  prompt(messages('you_dealt'))
  display_cards(p_hand)
  prompt "which adds up to: #{tally(p_hand, n)}"
  tally(p_hand, n)
end

def dealer_turn(d_hand, d_total, n, deck)
  loop do
    newline
    prompt(messages('dealer_dealt'))
    display_cards(d_hand)
    prompt "which adds up to: #{d_total = tally(d_hand, n)}"
    dealer_choice = dealer_hit_or_stay(d_total, n)
    break if dealer_choice == 'stay' || busted?(d_total, n)
    prompt(messages('dealer_hit'))
    d_hand << deal_cards!(deck, 1).flatten
  end
  d_total
end

def display_welcome(n)
  system 'clear'
  prompt "Welcome to #{n}!"
  prompt(messages('beat_dealer'))
  newline
end

scoreboard = { player: 0, dealer: 0 }
n = 0

loop do
  n = 0
  system 'clear'
  prompt(messages('21_variation'))
  n = choose_game_variation(n)
  display_welcome(n)

  deck = initialize_deck
  player_hand = deal_cards!(deck, 2)
  dealer_hand, unknown_card = deal_cards!(deck, 2)
  total_player = tally(player_hand, n)
  total_dealer = tally(dealer_hand, n)

  display_both_hands(player_hand, dealer_hand, total_player)

  total_player = player_turn(player_hand, total_player, n, deck)
  dealer_hand = [dealer_hand] + [unknown_card]
  choice = nil

  if busted?(total_player, n)
    game_over(player_hand, dealer_hand, scoreboard, n)
    play_again?(choice) == 'y' ? next : break
  end
  prompt(messages('you_stay'))

  newline
  prompt(messages('dealer_unknown'))
  total_dealer = dealer_turn(dealer_hand, total_dealer, n, deck)
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
