VALID_CHOICES = {
  'r' => 'rock',
  'p' => 'paper',
  'sc' => 'scissors',
  'l' => 'lizard',
  'sp' => 'spock'
}

WINNING_COMBOS = {
  'rock' => ['lizard', 'scissors'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'lizard' => ['spock', 'paper'],
  'spock' => ['scissors', 'rock']
}

def prompt(message)
  Kernel.puts("=> #{message}")
end

def clear_screen
  print "\033[2J\033[H"
end

def display_welcome
  prompt("Welcome to Rock, Paper, Sissors, Lizard, Spock!")
  prompt("Can you beat the computer 5 times?")
end

def display_choice_prompt
  choice_prompt = <<-MSG

  Pick one:

  r = rock
  p = paper
  sc = scissors
  l = lizard
  sp = spock
  MSG
end

def get_player_choice(choice)
  loop do
    Kernel.puts(display_choice_prompt)
    choice = Kernel.gets().chomp()
    if valid_choice?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end
  choice
end

def valid_choice?(choice)
  VALID_CHOICES.key?(choice) || VALID_CHOICES.value?(choice)
end

def convert_player_choice?(choice)
  if VALID_CHOICES.key?(choice)
    VALID_CHOICES[choice]
  else
    choice
  end
end

def get_computer_choice
  VALID_CHOICES[VALID_CHOICES.keys.sample]
end

def update_score(player, computer, scoreboard)
  if WINNING_COMBOS[player].include?(computer)
    scoreboard[:player] += 1
  elsif WINNING_COMBOS[computer].include?(player)
    scoreboard[:computer] += 1
  end
end

def display_who_won?(player, computer)
  if WINNING_COMBOS[player].include?(computer)
    prompt "You Won!"
  elsif WINNING_COMBOS[computer].include?(player)
    prompt "Computer Won!"
  else
    prompt "It's a tie!"
  end
end

def display_grand_winner(scoreboard)
  if scoreboard[:player] > scoreboard[:computer]
    prompt "You!!!"
  elsif scoreboard[:player] < scoreboard[:computer]
    prompt "Computer!!!"
  end
end

def display_choices(choice, computer_choice)
  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")
end

def display_score(scoreboard)
  prompt("score: you:#{scoreboard[:player]} computer:#{scoreboard[:computer]}")
end

def grand_winner?(scoreboard)
  if scoreboard[:computer] == 5 || scoreboard[:player] == 5
    prompt("Grand winner goes to...")
    display_grand_winner(scoreboard)
    scoreboard[:computer] = 0
    scoreboard[:player] = 0
  end
end

def play_again?
  loop do
    prompt("Play again? Type y/yes or n/no")
    answer = gets().chomp().downcase
    if answer == 'n' || answer == 'no'
      prompt("Thank you for playing. Good bye!")
      Kernel.exit()
    elsif answer == 'y' || answer == 'yes'
      break
    else
      prompt("That's not a valid choice.")
    end
  end
end

scoreboard = { player: 0, computer: 0 }

loop do
  clear_screen
  display_welcome

  choice = get_player_choice(choice)

  choice = convert_player_choice?(choice)

  computer_choice = get_computer_choice

  display_choices(choice,computer_choice)
  display_who_won?(choice, computer_choice)

  update_score(choice, computer_choice, scoreboard)
  display_score(scoreboard)

  grand_winner?(scoreboard)

  play_again?
end