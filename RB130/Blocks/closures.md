# WHat are closures?

Closures are a **programming concept** about saving a piece of code to execute it at a later time.

"Closure" come from the concept of "enclosing" or encapsulating(**?**) its surrounding variables, methods and objects (within a closure). They can later be referenced when the closure is executed.

Think about closures as undefined methods that can be passed around and executed.

There are 3 ways to work with closures in Ruby
1. Lambdas
2. `Proc` class
3. blocks

# Bindings

Binding allows closures to refer to the artifacts that were in scope when the closure was created. The closure retains access to these variables even if in another scope because it saves the binding of when it was initialized.

Procs, blocks and lambdas are different from other constructs. When a proc is instantiated a binding is created that inherits references to the local variables in the context the block was created.

```ruby
foo = 1
proc { foo }.call # 1
```
Internally, `proc { foo }` created on a second line a new binding that allows it to call the value of `foo`. The proc's binding **holds the reference to the variable `foo` rather than a copy of its value**. The creation of the binding at the proc initialization also explains why we can't call a variable that hasn't been intialized yet.

## Understanding scope

Scope refers to the bindings available at a specific part of the code. A binding binds a name to a memory reference. A scope is based on the location in the code.

Ruby keeps track of its current scope with its bindings. Bindings encapsulate the execution context at each position in the code.

We can check the binding at any point by calling the `binding` method — it returns a `Binding` object. On that object we can call methods to better understand the binding — like `local_variables`, which returns the local variables in scope as symbols in an array.
```ruby
#Binding object
binding # => #<Binding:0x00007fe15682e120>

# Array results shorten for clarity
foo = 1
binding.local_variables # [:foo]
zip = "zap"
fee = 3
binding.local_variables # [:fee, :zip, :foo]
```

What's interesting from the `Binding` object is that we can use the symbols it returns to access a local variable via the `binding#eval` method. The nuance is that **the binding can be passed around — and is saved in closures when they're initialized — which explains why closures can access local variables out of scope**.
```ruby
# Referencing variables from the binding object

binding.eval("foo")      # 1
binding.eval("zip")      # "zip"
binding.eval("fee")      # 3
```

# `to_proc`

Symbols, hashes (!), and methods (!!) can be converted to procs using their `#to_proc` methods. The most common is `Symbol#to_proc` when iterating through collections.

```ruby
[1, 2, 3].map(&:to_s)
[1, 2, 3].map { |i| i.to_s }
[1, 2, 3].map { |i| i.send(:to_s) }
```
Note that `Object#send` passes a symbol parameter that represents the method name — and is thus equivalent to calling the same method with a `.` notation.

But how does `Symbol#to_proc` look like under the hood? It's the equivalent of:
```ruby
class Symbol
  def to_proc
    Proc.new { |obj, *args| obj.send(self, *args) }
  end
end
```

`&` does two things: i) if it's passed with an object that isn't a `Proc`, it calls `#to_proc` and ii) it converts a `Proc` into a block

```ruby
# Step 1: ampersand operator and symbol
[1, 2, 3].map(&:to_s)

# Step 2: convert symbol to Proc
to_string = Proc.new { |obj, *args| obj.send(:to_s, *args) }

# Step 3: convert the Proc to a block with the ampersand operator
[1, 2, 3].map &to_string
```

We can prove that `&` followed by a `Proc` turns the proc into a block through
```ruby
five = Proc.new { 5 }

def yield_block
  yield
end

puts five  # Proc object
puts &five # => nil
yield_block &five # 5
```

What happened?
- `puts &five`: we confirm that `five` is a proc object
- `puts &five`: we display nothing and return `nil` because `puts` doesn't yield a block — and `&` converted `five` into a block
- `yield_block &five`: `&five` converts the proc into a block, passes it implicitly to `yield_block`, and yields the block

# Ampersand parameter

This is how we explicitly accept blocks in a method. Note that this isn't a proper argument — calling a method with anything but a block will result in `ArgumentError`. When a block is passed as an ampersand parameter it the ampersand operator will automatically convert it into a proc. A proc is an instance of the `Proc` class that can hold a code block to be executed later.

Note that converting a block into a proc also means that there's a performance hit from creating an boject. Whenever possible, use implicit blocks.



