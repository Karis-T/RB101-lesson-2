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

def total_score(player, computer, scoreboard)
  if WINNING_COMBOS[player].include?(computer)
    scoreboard[:player] += 1
  elsif WINNING_COMBOS[computer].include?(player)
    scoreboard[:computer] += 1
  end
end

def display_results(player, computer)
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

scoreboard = { player: 0, computer: 0 }

prompt("Welcome to Rock, Paper, Sissors, Lizard, Spock!")
prompt("Can you beat the computer 5 times?")


loop do
  choice = ''
  loop do
    choice_prompt = <<-MSG

        Pick one:

        r = rock
        p = paper
        sc = scissors
        l = lizard
        sp = spock
        MSG

    prompt(choice_prompt)

    choice = Kernel.gets().chomp()

    if VALID_CHOICES.key?(choice) || VALID_CHOICES.value?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES[VALID_CHOICES.keys.sample]

  if VALID_CHOICES.key?(choice)
    choice = VALID_CHOICES[choice]
  end

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  total_score(choice, computer_choice, scoreboard)
  prompt("score: you:#{scoreboard[:player]} computer:#{scoreboard[:computer]}")

  if scoreboard[:computer] == 5 || scoreboard[:player] == 5
    prompt("Grand winner goes to...")
    display_grand_winner(scoreboard)
    break
  end

  prompt("Press any key to play again. Type 'n' to exit")
  answer = gets().chomp()
  break if answer.downcase.start_with?('n')
end

prompt("Thank you for playing. Good bye!")
