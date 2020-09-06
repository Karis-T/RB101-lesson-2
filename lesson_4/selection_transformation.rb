# hash selection
produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}
def select_fruit(old_hash)
  hash_keys = old_hash.keys
  value = 0
  new_hash = {}

  loop do
    break if value == hash_keys.size
    if old_hash[hash_keys[value]] == 'Fruit'
      new_hash[hash_keys[value]] = old_hash[hash_keys[value]]
    end
    value += 1
  end
  new_hash
end

p select_fruit(produce)

# array transformation (mutation)
def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size
    numbers[counter] *= 2
    counter += 1
  end

  numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_numbers!(my_numbers) # => [2, 8, 6, 14, 4, 12]


# array selection transformation
def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_odd_numbers(my_numbers)

# flexible methods
def multiply(array, factor)
  new_array = []
  counter = 0
  loop do
    break if counter == array.size
      new_array << array[counter] * factor
      counter += 1
  end
  new_array
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3)

# flexible method selection
