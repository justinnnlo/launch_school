# 1. What is printed below?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers # [1, 2, 3, 3] because uniq doesn't mutate `numbers`
# IMPROVEMENT: puts prints each element in a newline because it automatically adds to_s to 

# 2.