# Runaway loop
loop do
  puts 'Just keep printing...'
  break
end

# Loopception
loop do
  puts 'This is the outer loop.'

  loop do
    puts 'This is the inner loop.'
    break
  end

  break
end

puts 'This is outside all loops.'

# Control the loop
iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1
  break if iterations > 5
end

# Loop on Command
loop do
  puts 'Should I stop looping'
  answer = gets.chomp
  break if answer = 'yes'
end

# Say Hello
5.times{ puts 'Hello!'}

say_hello = 0

while say_hello < 5
  puts 'Hello!'
  say_hello += 1
end

say_hello = true
count = 0

while say_hello
  puts 'Hello!'
  count += 1
  say_hello = false if count == 5
end

# Print while
numbers = (0..99).to_a
counter = 0

while counter < 5
  puts numbers.sample
  counter += 1
end

numbers = []

while numbers.size < 5
  numbers << rand(100)
end

puts numbers

# Count up
count = 1

until count > 10
  puts count
  count += 1
end

# Print Until
numbers = [7, 9, 13, 25, 18]
counter = 0

until counter == numbers.size
   puts numbers[counter]
   counter += 1
 end

# That's odd
for i in 1..100
  puts i if i.odd?
end

# Greet your Friends
friends = ['Sarah', 'John', 'Hannah', 'Dave']
for friend in friends
  puts "Hello, #{friend}!"
end
