# Simple loops

The simplest loops are made using the `loop` method and passing a block with `{}` or `do/end`. It doesn't have a built-in mechanism to control the loop execution, which is why it can create an infinite loop if you aren't careful.

For example, this only stops when you hit CTRL + C
~~~
loop do
  puts "Welcome to my infinite loop!!!"
end
~~~

Is this better?
~~~
loop do
  if x > 20
    x -= 1
  end
end
~~~
Not really! While it controls the flow of the program (subtract 1 if x is larger then 20, do nothing otherwise) it never stops the loop. This never ends because we never tell it to stop.

# Controlling loop execution

Control flow is used to manage loop execution. It typically uses conditionals to control the flow and direct the loop's execution. They use the mechanisms discussed in the previous chapter.

Within methods, explicit returns are used to stop the execution of method — which is relevant when loops are used.

## break

The `break` reserved keyword is helpful in that it stops a loop. But it only works for 1 level of the loop!

~~~
loop do
  loop do
    if x > 20
      x -= 1
    else
      break # breaks the second loop if x < 20, but it stays within an infinite loop because the first loop remains 
    end
  end
end
~~~

So to fix the above program, we'd have to modify it to:

~~~
loop do
  if x > 20
    x -= 1
  else
    break # breaks the loop if x < 20 
  end
end
~~~

## next

`next` conserves the loop but has it go to the **next iteration**. Thus, it does not break the loop. 

In the example below, `break` needs to be executed to stop the loop after the `for` loop ends. 

~~~
loop do
  for i in (0..20)
    if i.remainder(4) == 0
      puts "#{i} is divisible by 4"
    elsif i.remainder(2) == 0
      puts "#{i} is divisible by 2"
    else
      next
    end
  end
  break
end
~~~

But the more elegant program is naturally

~~~
for i in (0..20)
  if i.remainder(4) == 0
    puts "#{i} is divisible by 4"
  elsif i.remainder(2) == 0
    puts "#{i} is divisible by 2"
  else
    next
  end
end
~~~

**Bad loop execution risks creating an infinite loop** that crashes the program. Avoid it at all costs!

# While loops

While loops execute the code until a certain parameter is met. At it's core, it operates as a boolean: `while x < 10`, execute the loop, `where x < 10` evaluates to the boolean `true`. When `x < 10` is false, the loop stops executing and **returns `nil`**.

~~~
while x > 10
  x -= 1
end
~~~

Given its boolean structure, it will 
- Not work with a value that is `false` — specifically `nil` or `false`
- Create an infinite loop if `while true` is used until `break` is used

The second point is subtle but important — you need to build in how the loop ends with `break` if you're using `while true` to avoid an infinite loop.

# Until loops

These are similar to while loops, but it flips its approach. Instead of doing something **while** a certain condition is met, it does something **until** it's met. Otherwise, it's identical**?**.

~~~
until x < 10
  x -= 1
end
~~~

# Do/While loops

These loops are a `loop` method where at the end you establish a while-like conditional.

The **purpose** of these loops are to have at least one iteration followed by a logic at the end to determine whether it continues or not.

~~~
loop do
  puts "Helloooo!"
  x += 1
  break if x > 20 # The while-like functionality
end
~~~

# For loops

For loops iterate through a range of numbers, string, or array. Its structure is: `for [placeholder] in [iterator]:` and stops with end at the program's last line.

Four important nuances are that
- `for` loops have a definite end, unlike the `while` and `loop` methods
- `for` loops are within the program execution — so outer variables can be called within a for loop.
- It returns the parameter that was sent to the loop
  - `for i in (0..3)` returns the range 0..3
- A variable can be made to equal the result of the range

~~~
a = for i in (0..3)
  p i
  end
a
=> 0..3
a.class
=> Range
~~~

## Range of numbers

To tierate through a set of numbers, it has to be in a range. Ranges in Ruby need to have the beginning and end number within a parentheses. If we were iterating from 0 to 10, it'd be (0..10).

This isn't just for numbers. Other data types that need to be iterated with a range include:
- Strings: it needs to go through a range of (0...string.length) — `for i in "hello"` returns an error
- Hashes: it needs to go through a range of (0...hash.keys.length) to iterate through its keys or values

A small but important caveat is that the number of periods separating the 2 numbers tells the program whether to include or not the last number. (0..10) with 2 periods says "10 inclusive" while (0...10) with 3 periods says "10 exclusive".

## Arrays

Arrays are the only data type that can be used as an argument in the for loop. The for loop iterates in sequential order through the **elements of the array**. It's constructued identically as with range, put instead you just place the array: `for i in [0,1,2]`

# Conditionals within loops

# Iterators

Iterators are methods that naturally iterate over each element of an object. Iterators vary by data type and purpose

Data types
- Range of numbers
- Strings
- Arrays
- Hashes/dictionaries

Iterators use blocks to specify what to do as it cycles through an object.

Iterators can also vary according by purpose: `each`, `map`, and `inject` all have different purpose.

# Recursion

A recursive function calls itself. Its the programming equivalent of the matryoshka doll — you find another version of the same within each until it finishes its task.

The main risk of using a recursive function is that it enters an infinite loop — it calls itself again and again until it crashes. Thus, like a matroyshka doll, you need to place limits — flow control — on the function.

This is why recursive functions tend to have base cases where it stops calling itself. For example, this is how we'd recursively get the factorial of a number.

~~~
def factorial(num)
  if num == 1 # Base case to stop the recursion
    return 1
  else
    return num * factorial(num - 1) # 
  end
end
~~~

**When should we use recursion?**
I can't think of an algorithm to determine that — I'm approaching this intuitively so far.

A clear criteria is that the function's task has to be at least partly repetitive. Otherwise, there's no need to use recursion.