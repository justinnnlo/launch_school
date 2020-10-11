# What is this about?

Besides iteration, the two most common actions of a loop are to select and transform a collection.

Selecting from a collection means using a criteria to choose what elements to single out. Transforming a collection means manipulating every element in a collection. In sum, if there are `n` elements in a collection selection results in `n` or less elements while transformation results in `n` elements.

Note that transforming a collection can involve object mutation. Pay attention if you do it or not!

```ruby
# Select key-value pairs where the value is `Fruit`

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(produce)
  count = 0
  keys = produce.keys
  result = {}

  loop do
    break if count >= produce.length

    result[keys[count]] = produce[keys[count]] if produce[keys[count]] == "Fruit"
    count += 1 # Missed iterator
  end
  result
end

select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
```

```ruby
# Transform each element by multiplying each element of an array of numbers by 2
# Requirements
  # Input: array of integers
  # Output: a new array of integers
  # Implicit: iterate through the array with loop, double each element and store it in a new array

my_numbers = [*1..5]

def double_numbers(numbers)

  doubled_numbers = []
  count = 0
  loop do
    break if count >= numbers.length

    doubled_numbers << numbers[count] * 2
    count += 1
  end
  doubled_numbers
end

# Variation: same as above but mutating the array

def double_numbers!(numbers)

  count = 0
  loop do
    break if count >= numbers.length

    numbers[count] *= 2
    count += 1
  end
  numbers
end

double_numbers(my_numbers) # Does not mutate object
double_numbers!(my_numbers) # Mutates object

# Variation 2: transform a selection of the even numbers

def double_odd_numbers(numbers)

  result = []
  count = 0
  loop do
    break if count >= numbers.length

    if numbers[count].odd?
      result << numbers[count] * 2
    else
      result << numbers[count]
    end
    count += 1
  end
  result
end

# Variation 4: transform a selection of numbers with odd indices

def double_odd_indices(numbers)

  result = []
  count = 0

  loop do
    break if count >= numbers.length

    if count.odd?
      result << numbers[count] * 2
    else
      result << numbers[count]
    end
  
    count += 1
  end
  
  result
end
```

```ruby
# Code a method that allows you to multiply every array item by a specified value

def multiply_array(array, number)
  result = []
  count = 0

  loop do
    break if count >= array.length

    result << array[count] * number
    count += 1
  end

  result
end
```

```ruby
# Problem: create a new string with the number of times a chatacyer appears in the input string"
# Requirements
  # Input: string
  # Output: new string
  # Empty string/other data type: ""
# Algorithm: count the # times it appears and then multiply it by the character

def select_letter(string, char)
  count = 0
  counter = 0

  loop do
    break if counter >= string.length

    count += 1 if string[counter] == char
    counter += 1
  end

  char * count
end
question = 'How many times does a particular character appear in this sentence?'
select_letter(question, 'a') # => "aaaaaaaa"
select_letter(question, 't') # => "ttttt"
select_letter(question, 'z') # => ""