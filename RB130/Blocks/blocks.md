# Calling methods with blocks

In a method call a block is an argument — much like an object like `5` or `"hi"` can be an argument in other type of methods.

Blocks are enclosed in `do...end` or `{...}` and placed after the method invocation.

Not all methods can take in a block. If a method is not designed to take in a block, it returns `nil`

```ruby
p { 5 }
=> nil
```

When looking at a method invocation with a block, we have to be able to break them down into their constituent parts:

```ruby
[1, 2, 3].each { |n| p n }
```
Where `[1, 2, 3]` is the calling object, `.each` is the method we're calling on the object, and `{ |n| p n }` is the block passed to the method as an argument.

# Methods and blocks

Every method in Ruby can take a block.

```ruby
def hello
  "hello!"
end

hello("hi")         # ArgumentError: wrong number of arguments
hello { puts "hi" } # => "hello"
```
`hello("hi")` returned an `ArgumentError` because it wasn't expecting any arguments.

So why did passing a block not return an error?

Because passing a block isn't like passing another object parameter. In Ruby, **every method can take in an optional block as an implicit parameter** by placing it at the end of the method invocation.

However, the method doesn't do anything in the block (hence why `puts { 5 }` returned `nil` — it was like executing `puts`) unless we specify it.

# Yielding

We can invoke the passed-in block from within the method with the `yield` **keyword**.

```ruby
# echo
def echo(str)
  str
end

echo { "Hello!" }                # => ArgumentError
echo("hi")                       # => "hi"
echo("hi") { "Hello!" }          # => "hi"
echo("hi", "there") { "Hello!" } # => ArgumentError

# echo_with_yield
def echo_with_yield(str)
  yield
  str
end

echo_with_yield { "Hello!" }                     # => ArgumentError
echo_with_yield("hi")                            # => LocalJumpError: no block given (yield)
echo_with_yield("hi") { puts "Hello!" }          # prints "Hello!" => "hi"
echo_with_yield("hi", "there") { "Hello!" }      # => ArgumentError
```
This code block tells us that:
1. Regardless of `yield`, the method needs to take in the appropriate number of arguments
2. `yield` executes the code inside the block — i.e., it injects additional code through the block in the middle of the method
3. If we have `yield` but do not send a block it'll produce a `LocalJumpError`

To avoid `LocalJumpError` we can use the `Kernel#block_given?` method that executes `yield` only if a block is passed.

```ruby
# echo_with_yield
def echo_with_yield(str)
  yield if block_given?
  str
end

echo_with_yield { "Hello!" }                     # => ArgumentError
echo_with_yield("hi")                            # => "hi"
echo_with_yield("hi") { puts "Hello!" }          # prints "Hello!" => "hi"
echo_with_yield("hi", "there") { "Hello!" }      # => ArgumentError
```

## Method implementation vs invocation

Method implementation is the method definition.

Method invocation is when a method is invoked on an object.

```ruby
# method implementation
def say(words)
  yield if block_given?
  puts "> " + words
end

# method invocation
say("hi there") do
  system 'clear'
end  # clears screen first, then outputs "> hi there"
```

## Tracing the method execution
When we run the code block above, the code execution follows the following pattern:

- Line 8 (`say("hi there") do`): method invocation with 2 arguments — "hi there" and the block
- Line 2 (`def say(words)`): method local variable is assigned the string `"hi there"` and the block is passed implicitly, without variable assignment
- Line 3 (`yield if block_given?`): `yield` (and thus the block) is executed as `block_given?` returns `true`
- Line 9 (`system 'clear'`): the block is executed given it was called by `yield`
- Line 4 (`puts "> " + words`): after the block is done executing, method execution continues in line 4 — displaying `"> hi there"` and returning `nil`
- Line 5 (`end`): the method ends and the last expression's value (`nil`) is returned by the method

Thus, the execution was:
```
line 8 → line 2 → line 3 → line 9 → line 4 → line 5
```
Note that line 8 jumps to line 2, and line 3 jumps to line 9. This suggests how the execution of a block is similar to that of a method. This is why it's helpful to think of a block as an unnamed method.

## Yielding with an argument

Some blocks require an argument, such as:

```ruby
3.times do |num|
  puts num
end
```
Where the object `3` calls the `.times` method, which is passed as an argument the block:
```ruby
        do |num|
  puts num
end
```
which itself has the block parameter `num` placed within the two `|`. As a block parameter, `num` is a **block local variable** — a special type of local variable whose scope is constrained to the block.

As it's a local variable, block parameters shouldn't conflict with any local variables outside the scope to avoid variable shadowing — and thus prevent us from accessing local variables defined in the outside scope.

### Building-in flexibility with yields and arguments

We can define methods that act in different ways — depending on whether they are passed in a block or not.

This is helpful in case we want to execute a more complicated action with the block.

```ruby
# method implementation
def increment(number)
  number + 1
end

def increment_with_block(number)
  if block_given?
    yield(number + 1)
  end
  number + 1
end

# method invocation
increment(5)                     # => 6

increment_with_block(5) do |num| # num == number + 1
  puts num                       # Display 6
end                              # => nil
```

For `increment(5)` execution is:
```
Line 14 → Line 2 → Line 3 → Line 4 → program ends
```

For `increment_with_block(5)` execution is:
```
Line 16 → Line 6 → Line 7 → Line 8 → Line 16 → Line 17 → Line 18 → Line 9 → Line 10 → Line 11 → program ends
```

### Passing the wrong number of arguments to a block

```ruby
# method implementation
def test
  yield(1) # passing 1 block argument
end

# method invocation
test do |num1, num2|                    # expecting 2 parameters in block implementation
  puts "#{num1} #{num2}"
end
```

In the above example, we're **passing less arguments than the block expects**. `num1` block local variable is `1` while `num2` is `nil`. This displays `"1 "` because in string interpolation `nil` is converted to an empty string.

Therefore, the default values of block local variables — like instance variables — is `nil`.

```ruby
# method implementation
def test
  yield(1, 2)                           # passing 2 block arguments at block invocation time
end

# method invocation
test { |num| puts num }                 # expecting 1 parameter in block implementation
```

In this example we're **passing more arguments than the block expects**.

Here the **block ignores the second parameter** — and just displays `1` to the output

## Arguments in blocks, `Proc` and `lambda`

The rules that specify the number of arguments you can pass to blocks, `proc` and `lambda` is called their **arity**. In Ruby, blocks have lenient arity rules — which is why the block doesn't complaint when you pass in a different number of arguments.

However, `proc` objects and `lambda`s have different arity rules.

Regarding blocks, remember that Ruby won't enforce argument counts — it doesn't raise errors.

## When to use blocks in methods

The 2 main use cases are:

1. Defer some implementation code to the method invocation
  - When you work with methods there are 2 people you have to be aware of: the method implementor and the method caller (though they might be the same person)
  - If the method implementor is not 100% certain of how the method caller want to use the method, it makes sense to allow blocks
    - Without blocks, we can still have some flexibility in methods: e.g. case statements, if statements, etc.
    - But it's much greater with blocks because it allows you to inject code in the method
      - E.g. `map`, `inject`, `times`, `select` are so useful precisely because they so much flexibility
      - In contrast, imagine a `select_odds` and `select_evens` method rather than the more general `select` method — a bummer!
        - Thus, blocks allow us to work with less and more general methods — making programming easier
2. Sandwich code: "before" and "after" actions
  - Examples:
    - Taking the time before and after something (useful for: timing, logging, notification systems)
      ```ruby
      def time_it
        time_before = Time.now
        yield                       # execute the implicit block
        time_after= Time.now

        puts "It took #{time_after - time_before} seconds."
      end

      time_it { sleep(3) }                    # It took 3.003767 seconds.
                                              # => nil

      time_it { "hello world" }               # It took 3.0e-06 seconds.
                                              # => nil
      ```
## Explicit blocks

So far we've only passed blocks implicitly (though explicitly calling them within the method with `yield`).

Blocks are passed explicitly by prepending a parameter with `&`, such as:

```ruby
def test(&block)
  puts "What's &block? #{block}"
end

test { "hello" }
# What's &block? #<Proc:0x00007fb41d0a2c78 (pry):4>
#=> nil
```

The `&` in `&block` converts the block into a `Proc` object. Yet notice that inside the method we drop the `&` and refer to the `Proc` without it — in the above case simply as `block`.

[Note that the `Proc` object ends with `(pry):4` after the object id encoding]

`Proc`s allow us to pass blocks to other methods as `Proc` objects — like we'd pass any other object.

```ruby
def test2(block)
  puts "hello"
  block.call                    # calls the block that was originally passed to test()
  puts "good-bye"
end

def test(&block)
  puts "1"
  test2(block)
  puts "2"
end

test { puts "xyz" }
# => 1
# => hello
# => xyz
# => good-bye
# => 2
```

# Blocks and variable scope

Variable scope was defined in RB101 in terms of inner and outer scopes, and self-contained and leaky scopes.

As per above, a block is an instance of how Ruby implements the concept of closure — a chunk of code that can be executed later, much like an unnamed method. Other instances include `Proc`s and `lambda`s.

[Note: blocks are a form of `Proc`s]

```ruby
name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
chunk_of_code.call # Displays "hi Robert"; => nil
```

Note that in the above example the variable has to be initialized before the `Proc` uses it. Though the `Proc` will still be saved, calling the `Proc` will return a `NameError` due to an uninitialized local variable.

```ruby
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Robert"
chunk_of_code.call # => NameError
```

This also suggests something else: that `Proc` was pre-processed. See the below example, where we call the `Proc` that references the local variable `name` from within the self-contained scope of `call_code` method:
```ruby
name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}

def call_code(code)
  code.call
end

call_code(chunk_of_code) # "hi Robert"
```

What's seems to be going on? It seems that when the `Proc` is instantiated it preprocesses the string — so it saves `"hi Robert"` or `NameError`. Thus, when the `Proc` is called it doesn't call the local variable `name`.

However, this isn't true. See here:
```ruby
name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Jose Agustin"

def call_code(code)
  code.call
end

call_code(chunk_of_code) # "hi Jose Agustin"

name = "Selina"

call_code(chunk_of_code) # "hi Selina"

```

This last example shows that `Proc` objects that call local variable are aware of the most recent value of the variable, unless the `Proc` was instantiated before the variable was initialized.

This implies that `Proc` objects keep track of its surrounding context. In Ruby this is called **binding** or surrounding environment/context.

Closures need to be aware of its bindings to have the information to be executed later. This isn't restricted to local variables — it also includes method references and constants (and more?).

A `Proc` can seemingly violate local variable scoping rules (remember the `Proc` calling `name` from within a self-contained scope?) because it's aware of its binding.

# Symbol to `Proc`

When we want to transform the elements of a collection we can use syntactical sugar:

```ruby
[1, 2, 3, 4, 5].map { |num| num.to_s }
# => ["1", "2", "3", "4", "5"]

[1, 2, 3, 4, 5].map(&:to_s)
# => ["1", "2", "3", "4", "5"]
```

This shortcut works on any collection that takes a block.

```ruby
["hello", "world"].each(&:upcase!)              # => ["HELLO", "WORLD"]
[1, 2, 3, 4, 5].select(&:odd?)                  # => [1, 3, 5]
[1, 2, 3, 4, 5].select(&:odd?).any?(&:even?)    # => false
```

In the above example, `(&:to_s)` is converted to `{ |num| num.to_s }` through the ampersand operator (`&`).

- When we add `&` in front of an object it tells Ruby to convert the object into a block — so it expects a `Proc` object
  - Ruby checks if the object after `&` is a `Proc`
    - If it is: it uses the `Proc` as it is and the `&` turns the `Proc` into a block
    - If it isn't: it calls `#to_proc` on the object
      - If it returns a `Proc` object: the `&` turns the `Proc` into a block
      - Otherwise: Ruby raises an error

```ruby
def my_method
  yield(2)
end

# Yield executes block and passes 2 as parameter
my_method { |n| n.to_s }

# Convert :to_s into a Proc and & executes the proc object
a_proc = :to_s.to_proc
my_method(&a_proc)

# Symbol -> Proc -> Calls block
my_method(&:to_s)
```

1. The execution of a block with `yield`
2. Converting the symbol `:to_s` into a `Proc` and having `&` turn it into a block to be called by `yield`
3. `&` converts `:to_s` into a `Proc`, then converts the `Proc` into a block and executes the code


## Nuances of explicit block parameters

Note that if we explicitly pass blocks we can still call the `Proc` object that is passed with `yield` — we aren't obliged to use `Proc#call`. Also, it doesn't raise an error if a method with an explicit block isn't passed one — but if called, t.

```ruby
def my_method(&block)
  p yield if block_given?
  p block.inspect
end

my_method { "block" } # => block; Proc object

my_method               # => nil; nil
```

However, we can't define a method to expect two explicit blocks:

```ruby
def my_method(&block1, &block2) # SyntaxError
end
```

But we can go around this by passing 2 proc objects
```ruby
def my_method(proc1, proc2)
  proc1.call
  proc2.call
end

my_proc1 = Proc.new { puts "hi" }
my_proc2 = Proc.new { puts "there" }

my_method(my_proc1, my_proc2) # displays "hi" and "there, => nil
```

And if we pass an explicit block it must be the last parameter passed

```ruby
def my_method(&block1, par) # SyntaxError
end
```

A parameter with an ampersand operator is only suitable for blocks — Proc and lambdas can't be passed through it.

```ruby
def my_method(&block)
  yield
end
my_proc = Proc.new { puts "hi" }
my_method(my_proc)        # ArgumentError: wrong number of arguments (given 1, expected 0)
my_method(my_proc.call)   # ArgumentError: wrong number of arguments (given 1, expected 0)
my_method { puts "hi" }   # => nil, displays "hi"
```

### When would we use explicit calls?

1. When we need an object to manipulate the code (rather than a block)
2. More readability


Checks if it's a block
  - If it is, it turns it into a Proc object

A proc is passed through a parameter — NOT an ampersand parameter — because it's an object and not a Proc
