Score: 17/18

Issues:
- Misread code: #2, #11
- Misread documentation: #19

First trial:
- 11: got it correct
- 19: made a different mistake, did not repeat it this time
- 2; Avoided my original mistake this time, but made another by not selecting a correct answer

# 1. What happens if we try to initialize a Hash that contains duplicate keys? — Correct

The value of the duplicate key is the last one (from left to right).

ANSWER: D

# 2. Identify all of the code implementations that correctly meet the following set of requirements.  — WRONG

Given an array of strings representing integers, iterate through all of the items in the array. If the integer value of the string is odd add it to a new array of odd integer strings. Once iteration is complete the new array should contain all of the odd integer strings from the original array.

a. Iterate through all items in an **array of strings representing integers**
b. If the integer value of the string is odd: add it to a new array of odd **string** integers
c. Else: do not add it to the new array

ANSWERS: C, D

A and B: push the string if the integer value **of the index** is odd

**PROBLEM**: missed that B iterates through each element rather than each index

# 3. Identify all of the code implementations that correctly meet the following set of requirements.  — Correct

Given an array of integers, for each integer output all integers from 1 to that integer; e.g. if the integer was 5, you would output 1, 2, 3, 4, 5.

1. Array of integers
2. Iterate through each element of the array
3. Print every integer from 1 to the current element of the array

Assumption: all positive and from 1..8

ANSWERS: A, C, D

B: loop breaks before it should when the counter is greater than the number of elements in the array.

# 4-6: requirements

The method takes 2 arguments
1. A sentence string consisting of 1 or more words
2. A value that represents a case type: snake case, camel case or upper snake case
3. Return the string transformed to its appropriate snake case

# 4.Identify the line of code that is causing the error.  — Correct

```ruby
def snake(str)
  words = str.split
  current_word = 1  # Does not start from the first word

  loop do
    words[current_word].downcase!

    current_word += 1
    break if current_word >= words.size
  end

  words.join('_')
end
```

ANSWER: A

# 5.Identify the line of code that is causing the error.  — Correct

```ruby
def camel(str)
  words = str.split(' ')
  counter = 0

  while counter > words.size # Error, never happens
    words[counter] = words[counter].capitalize

    counter = counter + 1
  end

  words.join
end
```

ANSWER: B

# 6.Identify the line of code that is causing the error. — Correct

```ruby
def upper_snake(str)
  words = str.split
  current_word = 0

  loop do
    current_word += 1 # Starts with index 1
    break if current_word == words.size

    words[current_word].upcase!
  end

  words.join('_')
end
```

ANSWER: B

# 7. Read the below statements regarding each and identify all the statements which are correct. You may assume that the block doesn't terminate the method prematurely. — Correct

ANSWER: C

A: incorrect because it will be less than 7 times if the block mutates the array
B: Incorrect because it returns the original object
C: CORRECT
D: No, it doesn't consider the array's truthiness

# 8. Read the below statements regarding select and identify all the statements which are correct. — Correct

ANSWERS: B, D

A: Incorrect, select would return an empty array if every block was false because no element is selected
B: CORRECT: the only thing that matters is the return value
C: Incorrect, a new array object with the same values would be returned
D: CORRECT: select returns a new hash with the selected key-value pairs

Note: when an empty block is passed it evaluates to false on each iteration — so it returns an empty object

# 9. Read the below statements regarding map and identify all the statements which are correct. Assume that the block does not mutate the array. — Correct

ANSWERS: B, C

A: False, it would returns an array object with `nil` for every element
B: Correct — it transforms, not selects, the elements
C: Correct
D: False, it returns an array

# 10. Identify all the code samples which are examples of selection. — Correct

ANSWERS: B, C

Selection as creating a new object where the criteria is met.

A: Incorrect, transforming every element < 3 and including the other ones
B: Correct, selecting elements
C: Correct
D: Incorrect, printing but not creating a new object with the selected elements

# 11. Identify all the code samples which are not examples of transformation.  — WRONG

ANSWER: A, B, C — because only D is a transformation
A: Correct because it does not modify elements but creates a new array object, BUT acts as if `map` just created a new object with the same values (or `select` under the same circumstances for that matter).
B: Correct — a selection method
C: Correct — Does the for method return a new array or the last mutated element? NO: **for loop returns the original object**
D: Incorrect — Transformation

MISSED that A has an upcase method

# 12. What's the method?  — Correct

B: Select because puts evaluates to nil and the new object is empty

# 13. What's the method? — Correct

D: None of the above because the block returns a truthy value but an empty array

# 14. What's the method? — Correct

C: map

# 15. What's the method? — Correct

A: each because it returns the original object

# 16. Select all true statements — Correct

ANSWERS: A, C

A: Correct, because map executes depending on the value returned by the block
B: False, it returns a new array
C: True, map creates a new array and returns it
D: False, map returns an item for each element in the object passed to it

# 17. Select all true statements — Correct

ANSWER: D

A: False, as puts has a return value of false reject it says "do not reject" to all elements
B: False, it depends on the truthiness of the blocks return value
C: False, it creates a new array
D: True, it only cares about the truthiness of the block's return value

# 18: Identify all of the code implementations that correctly meet the following set of requirements. — Correct

1. Array `numbers` that contains odd and even integers
2. Create 2 new arrays to select the i) odd and ii) even numbers

ANSWERS: A, B, C

Why is D incorrect? With partition, when the block evaluates to true it sends an element to the left — so the code has it backwards.

Rather than
```ruby
numbers = [1, 2, 4, 5, 7, 8, 10, 13, 14]
odd_numbers, even_numbers = numbers.partition do |number|
                              number.even?
                            end
```

It should be
```ruby
numbers = [1, 2, 4, 5, 7, 8, 10, 13, 14]
even_numbers, odd_numbers = numbers.partition do |number|
                              number.even?
                            end
```

# 19. WRONG

ANSWERS: B, C, D

1. Hash where keys are the countries and values are the capital cities
2. Return a new hash selecting the k/v pairs of countries beginning with "B"

A: Wrong because it's selecting based on the value (despite putting the placeholder "country" there)
B: True, creating a new hash object where the k/v pair is created when the first letter of the Key is "B"
  - String#chr selects the first element of a string
C: True
D: True

WHY: Unlike select, find_all returns a nested array — SHOULD'VE read the documentation carefully as it says it returns an array

# 20. Change from basic looping to iterative methods — CORRECT

ANSWER: D

1. Counter
2. Loop until the counter == size of data set
  - Capitalize each name
  - Select if last_login < 60 && subscribed_to_list

A: False, because it doesn't capitalize both names
B: Wrong because <= 60 != < 60
C: Wrong because last_login > 59
D: Correct