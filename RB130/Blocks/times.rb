require "byebug"

# times

def times(num)
  for i in 0...num
    yield(i) if block_given?
  end
  num
end

def times(num)
  counter = 0
  while counter < num
    yield(counter) if block_given?
    counter += 1
  end

  num
end

def times(num)
  counter = 0
  loop do
    break if counter >= num
    yield(counter) if block_given?
    counter += 1
  end

  num
end

def times(num)
  counter = 0
  until counter >= num
    yield(counter) if block_given?
    counter += 1
  end

  num
end

def times(num)
  counter = 0
  until counter >= num
    yield(counter) if block_given?
    counter += 1
  end

  num
end

times(5) { |num| p num }



# each

def each(object)
  for i in object
    yield(i) if block_given?
  end

  object
end

each([1,2,3]) { |n| p n }



# select

def select(object)
  solution = []

  if block_given?
    for i in object
      solution << i if yield(i)
    end
  end

  solution
end

select([1,2,3]) { |n| n.odd? }



# reduce

def reduce(object, *default)
  default.empty? ? acc = object[0] : acc = default[0]
  #byebug
  if default.empty?
    for i in 1...object.length
      acc = yield(acc, object[i])
    end
  else
    for i in 0...object.length
      acc = yield(acc, object[i])
    end
  end

  acc
end

#Revised reduce method

def reduce(object, default = object[0])
  for i in 1...object.length
    default = yield(default, object[i])
  end

  default
end

p reduce([1,2,3]) { |acc, n| acc + n }
array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
#p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']