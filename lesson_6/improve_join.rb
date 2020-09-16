# input: array
# output: string
# if there are 2 or more numbers in the array add an 'or ' before the last number
# if an optional comma is passed in, replace the default ',' when joining
# if an optional 'and ' is passed in, replace the default 'or '

def joinor(array, comma=', ', conjunction='or')
  if array.length == 2
    array.join(" ").insert(-2, "#{conjunction} ")
  elsif array.length == 1
    array.join
  else
    array.join(comma).insert(-2, "#{conjunction} ")
  end
end

p joinor([1])
p joinor([1, 2])                   # => "1 or 2"
p joinor([1, 2, 3])                # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"