Perfect — 10/10

Key insight: if the accelerator is added with nil in inject, it returns an error. A nil is generated when an if statement is false

# 1. Which of the following statements most accurately describes why that particular return value is produced? — CORRECT

```ruby
arr = ['340', '15', '1', '3400']

arr.sort # => ['1', '15', '340', '3400']
```

It sorts the string based on its ASCII values using the `<=>` operator. Longer string are considered greater than smaller ones.

ANSWER: D

# 2. — CORRECT

`<=>`: -1 means left is smaller

```ruby
a <=> b # => -1
c <=> b # => 0
d <=> c # => 1

[a, b, c, d]
```

ANSWER: C
- b is less than b
- b is equal to c, so they don't move
- d is larger than c, so will be after a, b, and c

# 3. Given the code below, select all the valid ways to return the value for the hash key :three. — CORRECT

```ruby
arr = [
  {one: '1', two: 2},
  [{four: 5, three: 6}, :three],
  :three,
  {2=>:two, 3=>:three}
]
```

arr[1][0][:three]

ANSWER: A

# 4. Given the following nested data structure, and without running the code, select the correct option to change the string 'Apple Juice' to 'Orange Juice'. — CORRECT

```ruby
todo_lists = [
  {
    id: 1,
    list_name: 'Groceries',
    todos: [
      { id: 1, name: 'Bread', completed: false },
      { id: 2, name: 'Milk', completed: false },
      { id: 3, name: 'Apple Juice', completed: false }
    ]
  }
]

todo_lists[0][:todos][2][:name] = "Orange Juice"
```

ANSWER: C

# 5. Given the following nested data structure, and without running the code, select all the options that would set the value for :completed to true for all of the todos in the 'Homework' list. — CORRECT

```ruby
todo_lists = [
  {
    id: 1,
    list_name: 'Groceries',
    todos: [
      { id: 1, name: 'Bread', completed: false },
      { id: 2, name: 'Milk', completed: false },
      { id: 3, name: 'Apple Juice', completed: false }
    ]
  },
  {
    id: 2,
    list_name: 'Homework',
    todos: [
      { id: 1, name: 'Math', completed: false },
      { id: 2, name: 'English', completed: false }
    ]
  }
]
```
ANSWER: A, B, C, D

# 6. What will the 3 last lines output? — CORRECT

```ruby
a = 'hi' # a points to "hi"
english_greetings = ['hello', a, 'good morning'] # Index 1 points to `a`

greetings = {
  french: ['bonjour', 'salut', 'allo'],
  english: english_greetings, # Points to enligh_greetings
  italian: ['buongiorno', 'buonasera', 'ciao']
}

greetings[:english][1] = 'hey' # index 1 points to "hey", mutates the object

greetings.each do |language, greeting_list|
  greeting_list.each { |greeting| greeting.upcase! } # Mutates english_greetings, all upcase now
end

puts a # "hi"
puts english_greetings[1] # HEY
puts greetings[:english][1] # HEY
```
ANSWER: D

# 7. What happens? — CORRECT

```ruby
[['a', 'b'], ['c', 'd'], ['e', 'f']].map do |sub_arr|
  sub_arr.map do |letter|
    letter.upcase
  end
end
```
Returns a new array with the same structure but wach element capitalized

ANSWER: C

# 8. Data restructuring — CORRECT

Problems
- Objective:
  - 1. Total value of orders per customer
  - 2. Total value of fulfilled orders per customer
- Approach:
  - 1. Convert data structure
  - 2. Extract information from the new data structure to meet objectives

**Old format**

```ruby
order_data = [
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 351, order_date: '12/04/16', order_fulfilled: true, order_value: 135.99},
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 383, order_date: '12/04/16', order_fulfilled: true, order_value: 289.49},
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 392, order_date: '01/10/17', order_fulfilled: false, order_value: 58.00},
  {customer_id: 32, customer_name: 'Michael Richards', order_id: 241, order_date: '11/10/16', order_fulfilled: true, order_value: 120.00},
  {customer_id: 32, customer_name: 'Michael Richards', order_id: 395, order_date: '01/10/17', order_fulfilled: false, order_value: 85.65},
  # rest of data...
]
```

**New format**

```ruby
customer_orders = [
  {
    customer_id: 12,
    customer_name: 'Emma Lopez',
    orders: [
      { order_fulfilled: true, order_value: 135.99 },
      { order_fulfilled: true, order_value: 289.49 },
      { order_fulfilled: false, order_value: 58.00 }
    ]
  },
  {
    customer_id: 32,
    customer_name: 'Michael Richards',
    orders: [
      { order_fulfilled: true, order_value: 120.00 },
      { order_fulfilled: false, order_value: 85.65 }
    ]
  },
  # rest of data...
]
```

Process:
- Iterate through each customer
- Create a new collection
- If the customer object doesn't exist
  - Save `customer_id` and `customer_name` as is
  - Create `orders` subhash
- Within `orders`, create a new element with 2 k/v pairs
  - `order_fulfilled` and `order_value`

A:
- If new object has a key for the customer ID


ANSWER: C

# 9. Extracting the data: all_orders — CORRECT

```ruby
all_orders =[
  {customer_id: 12, customer_name: 'Emma Lopez', total_order_value: 483.48},
  {customer_id: 32, customer_name: 'Michael Richards', total_order_value: 205.65},
  # rest of data
]

fulfilled_orders =[
  {customer_id: 12, customer_name: 'Emma Lopez', order_value: 425.48},
  {customer_id: 32, customer_name: 'Michael Richards', order_value: 120.00},
  # rest of data
]
```

customer_id, customer_name, total_order_value

ANSWERS: A, B, C,

D wrong because it doesn't create hashes

# 10. filtered orders: identify the bug — CORRECT

ANSWER: C

```ruby
fulfilled_orders = customer_orders.map do |customer|
  {
    customer_id: customer[:customer_id],
    customer_name: customer[:customer_name]
  }
end

customer_orders.each_with_index do |data, index|
  order_value = data[:orders].reduce(0) do |total, order|
    total + order[:order_value] if order[:order_fulfilled] # if false, returns nil => error because total + nil is invalid!
  end

  fulfilled_orders[index][:order_value] = order_value
end
```