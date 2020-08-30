# question 1: What would you expect the code below to print out?
# answer 1: numbers.uniq is a non mutating method and creates a copy of the array
# so the original numbers is unaffected
1
2
2
3

# Question 2: Describe the difference between ! and ? in Ruby.

# what is != and where should you use it?
# != means not equal to, which means the value is false. This can be used to exclude objects in conditions
# or when something isn't equal to something else

# put ! before something, like !user_name
# ! means not, which automatically turns the value into a false argument. In this case its "not" user_name
# can be used to exclude objects from conditions

# put ! after something, like words.uniq!
# known as the 'bang' operator, if ! is put after a method,
# typically but not always it becomes a method with the ability to permenantly mutate its caller
# this wont return a copy but itself mutated

# put ? before something
# prefixing any single character with a ? returns a string version of that

# put ? after something
# after an object or a method its looking to return a boolean value, true or false

# put !! before something, like !!user_name
# renders the object true or "is". The opposite of "not!"

# Question 3: Replace the word "important" with "urgent" in this string:
advice["important"] = "urgent"
advice.gsub!('important', 'urgent')

# Question 4:
# What do the following method calls do (assume we reset numbers to the original array between method calls)?
numbers.delete(1)
# this deletes the element 1 - which is index 0 mutating the caller
numbers.delete_at(1)
# this deletes the element at index 1 - which is 2 mutating the caller

# question 5: Programmatically determine if 42 lies between 10 and 100.
(10..100).include?(42)
(10..100).cover?(42)

# Question 6: show two different ways to put the expected "Four score and " in front of it.

"Four score and " + famous_words
"Four score and " << famous_words
"Four score and ".concat(famous_words)
famous_words.prepend("Four score and ")

# Question 7: Make this into an un-nested array.
flintstones.flatten!

# Question 8: Turn this into an array containing only two elements: Barney's name and Barney's number
flintstones.rassoc(2)
flintstones.assoc("Barney")