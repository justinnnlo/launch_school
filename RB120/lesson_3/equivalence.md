# Equivalence so far

We've been analyzing equivalence through the lenses of their values.

```ruby
"string" == "string" # => true
"string" == 10 # => false
10 == 10 # => true
```

So essentially equivalence asks: are their values the same?

Thus, equivalence find a way to compare the values associated with the objects.

# Equivalnce as objects

We can also compare the objects themselves via the `#equal?` method
```ruby
"string" == "string"     # => true
"string".equal? "string" # => false

s1 = "string"
s1.equal? s1             # => true
```

# `==` method

Unlike the `=` operator, `==` is an instance method available to all objects — it isn't an operator. The only reason we can use it in ways that seems like an operator, like doing `10 == 10`, is because of Ruby syntactical sugar.

[Side note: what's an operator? How's it different from a method?]

`==` is an instance method of the `BasicObject` class, which implies that it's available to all Ruby objects.

**The default implementation of `BasicObject#==` is equivalent to the `BasicObject#equal?` operator: it compares if 2 objects are the same (ie, have the same object id).**

This is why each native data type has its own `==` method — and why we should define our own if we're creating new classes that will require comparisons. Otherwise, we'll be comparing the object ids of 2 objects rather than their values.

# `===` method

This is used implicitly in the `case` statement. Under the hood, it uses `===` to compare the `when` clause with `num`.

Thus, as it isn't frequently used outside of it the main reason to define the `===` method in a custom class is if we're expecting to use a `case` statement.

```ruby
num = 25

case num
when 1..50
  puts "small number"
when 51..100
  puts "large number"
else
  puts "not in range"
end
```
In the above example, as we're using ranges the `Range#===` method is used in each clause. The above is equivalent to this refactoring as an `if` statement.

```ruby
num = 25

if (1..50) === num
  puts "small number"
elsif (51..100) === num
  puts "large number"
else
  puts "not in range"
end
```

This suggests what `===` does. Unlike `==`, it doesn't compare the values of the group nor does it compare their object ids like `equal?`.

Rather, it asks: if `(1..50)` is a group is `num` in the group?

Another variation is with classes.

```ruby
String === "hello"  # true
String == "hello"   # false

String === 10       # false

"hello" === "yes"   # false
"hello" === "hello" # true
```

# `eql?`

`eql?` compares whether the two objects have the same value and the same class.