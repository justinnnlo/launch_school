# def select_even(array, new_array = [], index = 0)
#   if index == array.length
#     return new_array
#   else
#     new_array << array[index] if array[index].even?
#     select_even(array, new_array, index + 1)
#   end
# end

# p select_even([1, 2, 3, 4, 5, 6])

def triangular_number(num)
  if num == 1
    return 1
  else
    return num + triangular_number(num - 1)
  end
end

def triangular_number(num, hash = { 1 => 1})
  p hash
  if !hash[num]
    hash[num] = num + triangular_number(num - 1, hash)
  end
  return hash[num]
end

# p triangular_number(1) # 1
# p triangular_number(2) # 3
# p triangular_number(3) # 6
# p triangular_number(4) # 10
# p triangular_number(5) # 15
# p triangular_number(7) # 28

# p triangular_number(1) # 1
# p triangular_number(2) # 3
# p triangular_number(3) # 6
# p triangular_number(4) # 10
# p triangular_number(5) # 15
# p triangular_number(7) # 28

# def find_x(string, index = 0)
#   if string[index] == 'x'
#     return index
#   else
#     find_x(string, index + 1)
#   end
# end

# p find_x('xabcdex')

def fibonacci(number, hash = { 0 => 0, 1 => 1 })
	if !hash[number]
		hash[number] = fibonacci(number - 1, hash) + fibonacci(number - 2, hash)
	end
	return hash[number]
end



# def fibonacci(number)
# 	return 0 if number == 0
#   first, second = 1, 0
#   (number - 1).times { first, second = first + second, first }
# 	first
# end

p fibonacci(0) # 1
p fibonacci(1) # 1
p fibonacci(2) # 1
p fibonacci(3) # 2
p fibonacci(4) # 3
p fibonacci(5) # 5
p fibonacci(6) # 8
p fibonacci(100)