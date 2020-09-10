# Practice problem 1
arr = ['10', '11', '9', '7', '8']

arr.sort do |a, b|
  b.to_i <=> a.to_i
end

arr.sort_by do |num|
  num.to_i
end.reverse

# practice problem 2
books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

books.sort_by do |hash|
  hash.map do |_, value|
    value.to_i
  end
end

# alternative since all years are 4 characters in length we can compare digit by digit

books.sort_by do |book|
  book[:published]
end

# practice problem 3
arr1[2][1][3]
arr2[1][:third][0]
arr3[2][:third][0][0]
hsh1['b'][1]
hsh2[:third].key(0) || hsh2[:third].keys[0]

# practice problem 4
arr1[1][1] = 4
arr2[2] = 4
hsh1[:first][2][0] = 4
hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4

# practice problem 5

munsters.map do |names, hash|
  if hash["gender"] == "male"
    hash["age"]
  end
end.compact.sum

total_male_age = 0
munsters.each do |key, value|
  total_male_age += details["age"] if details["gender"] == "male"
end

# practice problem 6

munsters.each do |key, hash|
  puts "#{key} is a #{hash["age"]}-year-old #{hash["gender"]}"
end

# practice problem 7

[4, [3,8]]

# practice problem 8

hsh.each do |_, arrays|
  arrays.each do |strings|
    strings.each_char do |chars|
      puts chars if chars =~ /[aeiou]/
    end
  end
end

# practice problem 9
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
arr.map do |arrays|
  arrays.sort {|a,b| b<=>a}
end

# practice problem 10
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hashes|
  hashes.transform_values do |num|
    num + 1
  end
end

[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  incremented_hash = {}
  hsh.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end

# practice problem 11
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]
arr.map do |arrays|
  arrays.select{|num| num % 3 == 0}
end

# practice problem 12
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

arr.each_with_object({}) do |array, hash|
  hash[array[0]] = array[1]
end
# alt
hsh = {}
arr.each do |item|
  hsh[item[0]] = item[1]
end

# practice problem 13
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
arr.sort_by do |array|
  array.select {|num| num.odd?}
end

# Practice Problem 14
hsh.map do |fruit, hash|
  if hash[:type] == "vegetable"
    hash[:size].upcase
  else hash[:type] == "fruit"
    hash[:colors].map {|string| string.capitalize}
  end
end

hsh.map do |fruit, hash|
  if hash[:type] == "vegetable"
    hash[:size].upcase
  else hash[:type] == "fruit"
    hash[:colors].map(&:capitalize)
  end
end

# practice problem 16
require 'securerandom'
def uuid
  hex = SecureRandom.hex
  hex.chars.map.with_index do |char, idx|
    if idx == 7 || idx == 11 || idx == 15 || idx == 19
      char << "-"
    else
      char
    end
  end.join
end
p uuid

def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end




