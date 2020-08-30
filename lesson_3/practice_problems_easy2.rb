# Question 1: In this hash of people and their age,see if "Spot" is present.
ages.key?("Spot")
ages.include?("Spot")
ages.member?("Spot")

# Question 2: Convert the string in the following ways:
# "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
munsters_description.swapcase!

# "The munsters are creepy in a good way."
munsters_description.capitalize!

# "the munsters are creepy in a good way."
munsters_description.downcase!

# "THE MUNSTERS ARE CREEPY IN A GOOD WAY."
munsters_description.upcase!

# Question 3: add ages for Marilyn and Spot to the existing hash
ages["Marilyn"] = 22
ages["Spot"] = 237
ages.merge!(additional_ages)

# Question 4: See if the name "Dino" appears in the string below:
advice.include?("Dino") => false
advice.match?(/Dino/) => false

# Question 5: Show an easier way to write this array
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Question 6: How can we add the family pet "Dino" to our usual array:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flinstones[-1] = "Dino"
flintstones[6] = "Dino"
flintstones << "Dino"

# Question 7: How can we add multiple items to our array? (Dino and Hoppy)
flintstones.push("Dino", "Hoppy")
flintstones.concat(%w(Dino Hoppy))

# Question 8: remove everything starting from "house".
advice.slice!(0..38)
advice.slice!(0, advice.index('house'))
advice.slice!(/Few things in life are as important as /)
advice.slice!("Few things in life are as important as ")
# if you use regular slice it just returns the slice string and the original remains the same

# Question 9: Write a one-liner to count the number of lower-case 't' characters in the following string:
statement.count "t"

# Question 10: If we had a 40 character wide table of Flintstone family members, how could we easily center that title above the table with spaces?
title.center(40)