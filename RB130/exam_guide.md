# Closures

A closure is a chunk of code that i) can be passed around, ii) can be executed later, and iii) has access to the artifacts in scope where the closure was created.

In Ruby there are 3 instances of closures: blocks, procs and lambdas.

Let's analyze both blocks and procs and see if they meet our definition (as lambdas are `Proc` objects with tigher arity rules):
- Blocks
  - Can be passed as implicit arguments to a method
  - Can be invoked on demand
  - Has access to the artifacts of when it was created
- Procs
  - Case be passed as any other object
  - Can be invoked on demand
  - Has access to the artifacts of when it was created

```ruby
def my_method(a_proc, &block)
  # Executing closures
  yield
  a_proc.call
end

im_a_block = "I'm a block!"
im_a_proc = "I'm a proc!"
a_proc = proc { puts im_a_proc }

# Passing closures
my_method(a_proc) { puts im_a_block }
```

However, there's some margin of debate on whether a block is a strict example of closure. It depends on what we imply with the idea that closures "can be passed around": does it satisfy this criteria if they can be implicitly passed around or do they need to be passed around as objects? If we choose the 2nd criteria, this would imply that blocks aren't strictly closures as we can't pass a block that is implicitly passed to a method to another method — it has to be converted to a `Proc`.


## Closures and scope

Closures can seemingly violate scoping rules because they have the binding of when they were created.

The binding is what is in scope at a particular moment. Since closures keep the binding at the point where they're created, they are able to reference that binding in other situations.

This ends up implying, for example, that a `Proc` object can access the artifacts created before it from within a self-contained method - where it shouldn't be possible. This is shown in the example below:

```ruby
not_in_var_scope = "hello!"

test = proc { not_in_var_scope }

def my_method(obj)
  obj.call
end

my_method test  # => "hello!"
```

At a more technical level, a binding is an object of class `Binding` that stores the artifacts that are in scope at that moment — it *binds* a name to a memory reference. For example, in line 3 below we see how the local variable `test` is stored in the array returned by `binding.local_variables`. Additionally, line 57 and 58 show how `binding.eval("test")` can reference the same object pointed to by `test`.
```ruby
test = "Hello"                  # 5
binding                         # => #<Binding:0x00007fec22961020>
binding.local_variables         # => [:test, :__, .....]
binding.eval("test")            # => "Hello"
binding.eval("test").eql?(test) # => true
```

# How blocks work, and when we want to use them.
# Blocks and variable scope
# Write methods that use blocks and procs
# Methods with an explicit block parameter
# Arguments and return values with blocks
# When can you pass a block to a method
# &:symbol

There are 2 `&` operators: the unary and binary `&` operators.
- Binary `&`
  - It has 2 operands
  - It can be used in many contexts and what it does varies by context
- Unary `&`
  - Acts on a simple operand (which it precedes)
  - Can only be used in method definitions and method invocations
    - E.g. `def my_method(&block)` or `[1,2,3].map(&:to_s)`
  - Method definition: expects to be passed a block that it converts to a `Proc` object
  - Method invocation: expects to be passed a `Proc` object and then turns it into a block
    - If another Ruby object is passed: it tries to convert the object to a `Proc` with `#to_proc`
    - Explains why we use a `Symbol` object: because it has `Symbol#to_proc`

# Testing terminology
- Test suite: the entire set of tests being run for the project. A test suite may comprise of multiple testing files.
- Test case: the description of a situation being tested. A test may have multiple assertions.
- Test step/Assertion: the verification of whether the program returns the data that we expect it to. An assertion is any instance of `assert` or `refute`.

# Minitest vs. RSpec

Rspec is a popular RubyGem testing library because it relies on a powerful DSL. That DSL enables us to write tests that can be read similarly to English.

In contrast, Minitest is Ruby's default testing library (though also a RubyGem). It's tests are typically written in Ruby, though it has its own DSL — Expectation syntax — that allows us to code the tests in text that's closer to English.

# SEAT approach

- Set-up: execute code before each test
- Execution: run code against the object being tested
- Assert: affirm the results of code execution
- Teardown: execute code at the end of each test (e.g. clean up lingering artifacts, close files, etc)

# Assertions
Assertions affirm whether the code that we've executed return the value we expect or not.

# Purpose of core tools
- Ruby version managers (RVM/Rbenv): software that helps us install, manage, and use different versions of Ruby
- RubyGems: Ruby files that we can download from remote libraries, install in our projects and execute in order to perform a specific functionality (from either the command line or a Ruby file)
- Bundler: a RubyGem that helps us install and manage RubyGems from within a project directory to deal with dependencies — multiple versions of Ruby and Gems needed in a project
  - Note: the specific name for this type of software is a **dependency manager**
- Rake: a RubyGem that allows us to automate tasks defined in `Rakefile` requires to build, test, package and install programs.
  - Set up required environment by creating directories and files
  - Set up and initialize databases
  - Run tests
  - Package your application and all of its files for distribution
  - Install the application
  - Perform common Git tasks
  - Rebuild certain files and directories (assets) based on changes to other files and directories
- Gemspec (less important): a file that allows us to define the ¿properties? of a RubyGem — thus helping us publish a new RubyGem
# Gemfiles