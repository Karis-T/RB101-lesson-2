# Question 1: What do you expect to happen when the greeting variable is referenced in the last line of the code?
# greeting will return nil if there has been any variable initialised within an if statement.

# Question 2: What is the result of the last line in the code below?
# greetings will output {a: "hi there"} as << is a permanent string mutational method which appends "there" onto the exisiting hash value

# Question 3: What will be printed by each of these code groups?
# A) one is one, two is two, three is three
# B) one is one, two is two, three is three
# C) one is two, two is three, three is one

# Question 4: Help Ben fix his code.
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.length == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end

  true
end