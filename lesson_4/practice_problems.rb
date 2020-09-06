# # practice 1
# hash = {}
# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# flintstones.map.with_index do |k, i|
#   hash[k] = i
# end
#
# p hash
#
# hash = {}
# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# counter = 0
#
# loop do
#   break if counter == flintstones.size
#   hash[flintstones[counter]] = counter
#   counter += 1
# end
#
# p hash
#
#
# # practice 2
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
#
# ages.values.sum
#
# total = 0
# ages.each{|_, v| total += v}
# total
#
# # practice 3
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
# ages.reject{|_, v| v >= 100}
#
# ages.select!{|_, v| v <= 100}
#
# # practice 4
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
# ages.min.pop
#
# ages.sort.first.last
#
# ages.values.min
#
# # practice 5
#
# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
#
# flintstones.each_with_index {|name, i| puts i if name.start_with?("Be")}
#
# counter = 0
# loop do
#   break if counter == flintstones.size
#   puts counter if flintstones[counter].start_with?("Be")
#   counter += 1
# end
#
# flintstones.index { |name| name[0, 2] == "Be" }
#
# # practice 6
# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
#
# flintstones.map! {|name| name = name[0, 3]}
#
# # practice 7
# statement = "The Flintstones Rock"
# statement.chars.tally
#
# # practice 8
# # weird stuff happens as its altering the array live iterators do not work on a copy
#
# # practice 9
# words = "the flintstones rock"
# words = words.split.map{|word| word.capitalize }.join(" ")
#
# words = "the flintstones rock".capitalize!
# counter = 0
# loop do
#  break if counter == words.length
#   if words[counter - 1] == (" ")
#     words[counter] = words[counter].upcase!
#   end
#   counter += 1
# end
# p words

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
names = munsters.keys
counter = 0

loop do
  keys = names[counter]
  break if counter == munsters.size
  if (munsters[keys]["age"] >= 18) && (munsters[keys]["age"] <= 64)
    munsters[keys]["age_group"] = "adult"
  elsif munsters[keys]["age"] > 64
    munsters[keys]["age_group"] = "senior"
  else
    munsters[keys]["age_group"] = "kid"
  end
    counter += 1
end
p munsters

munsters.each do |k, v|
  if (v["age"] >= 18) && (v["age"] <= 64)
    v["age_group"] = "adult"
  elsif v["age"] > 64
    v["age_group"] = "senior"
  else
    v["age_group"] = "kid"
  end
end
p munsters

munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end
