# Question 1: write a one-line program that creates the following output 10 times,
# with the subsequent line indented 1 space to the right:
10.times{|i| puts "The Flintstones Rock!".rjust(i+=21)}
10.times { |number| puts (" " * number) + "The Flintstones Rock!" }

# Question 2: The result of the following statement will be an error:
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{(40 + 2)}"
# error says no conversion of integer into string.

# Question 3:
# Alan wrote the following method, which was intended to show all of the factors of the input number:

def factors(number)
  divisor = number
  factors = []
  return factors if number == 0
  loop do
    factors << number / divisor if number % divisor == 0
    divisor -= 1 if divisor > 0
    divisor += 1 if divisor < 0
    break if divisor == 0
  end
  factors
end

# purpose of number % divisor is to determine all the multiples of the factor that have no remainders
# purpose of factors is to return the value of factors. ruby by default returns the last line of the method.

# Question 4
# rolling_buffer1 features an '<<' append sign therefore this permenantly mutates caller
# whereas rolling_buffer2 features a '+' concatenate sign which delivers a copy of the caller and doesnt mutate

# Question 5
# The limit variable is a local variable created outside the scope of the method definition.
# Unless the limit variable is passed in as an argument and a parameter to fib, it cannot be read by fib and therefore will return an error. To fix pass in 'limit' as an argument and a parameter to fib

# Question 6
34

# # Question 7
# Why? Remember that in Ruby, what gets passed in the parameter list is not what it appears. Under the hood, Ruby passes the object id of each item rather than the value of the parameter. The method internally stores these object id's in locally scoped (private to the method) variables (named per the method definition's parameter list).
#
# So Spot's demo_hash starts off pointing to the munsters hash. His program could wind up replacing that with some other object id and then the family's data would be safe.
#
# In this case, the program does not reassign demo_hash -- it just uses it as-is. So the actual hash object that is being messed with inside of the method IS the munsters hash.

# Question 8
"paper"

# Question 9
"no" / false