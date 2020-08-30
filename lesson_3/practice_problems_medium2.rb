# Question 1: Predict how the values and object ids will change throughout the flow of the code
# assigning a variable does not alter the object id as "=" acts like a non-mutational method.
# this means that before the block all the object ids will remain the same regardless of giving it a new variable.
# when its in the block only when new objects are reassigned to the variables the object id changes
# But because variable assignment isnt permenant and is only avilable within the scope of the block, when it exits the block, the object ids will return back to the original.

# Question 2: Predict how the values and object ids will change throughout the flow of the code
# Similar to the previous question, but a little bit different, before the method definition entry the object id's remain the same regardless of changing variables.
# instead of being passed to a block it is called by a method invocation.
# The method takes a copy of the value but not the variable into it and reassigns new values.
# Reassigning new values changes the object id. The method is then exited.
# As we saw before the original object ids remain intact. No changes were made as method variables are not accessible outside the scope of the method.

# Question 3: Study the code and state what will be displayed...and why:
# array will be changed to ["pumpkins", "rutabaga"], but the string remains unchanged.
# this is because += is a non-mutating method whereas << is a string mutation method
# << permenantly alters the array object

# Question 4: Study the code and state what will be displayed...and why:
# string will be changed to "pumpkinsrutabaga" and array will stay the same.

# Question 5: How can we refactor this practice problem to make the result easier to predict and easier for the next programmer to maintain?
def not_tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = not_so_tricky_method(my_string, my_array)

# Question 6: How could the unnecessary duplication in this method be removed?
def color_valid(color)
  color == "blue" || color == "green"
end
