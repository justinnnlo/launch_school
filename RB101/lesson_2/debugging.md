# Why is debugging important?

Trivial code is usually finished quickly. Thus, alongside tasks like solving problems debugging is one of the major activities a programmer does.

# Important things in debugging

## Temperament

Degugging can be frustruating. If you get frustruated easily, chances are higher you won't be as good of a programmer as you can be.

Luckily, you can — and should try to — develop a good temperament.

This means being cool in the face of unexpected problems and always focusing on how it can be solved and of those what's the best route.

## Reading error meassages

Error messages output a wall of gibberish text called the **stack trace**. This is critical in identifying the problem.

The key skill here is **learning what to look for in stack traces**. The error message is only the first hint.

A related subskill is how to use the stack trace to search online. Note that better results are given by:
- Knowing what parts of the stack trace are more relevant
- Excluding parts of the stack trace related to your local environment
- Specifying the language (e.g. Ruby) or library involved

For example, if you get `NoMethodError: undefined method 'name' for nil:NilClass` it's best to exclude 'name' because that's specific to your program.

Note that **every language and library have different patterns to their stack traces**. Study them if you're working with new ones.

# Steps to Debugging

1. Reproduce the error to **isolate the root cause**
2. Determine the boundaries of the error to better understand the problem
  - Tweak the data to see how that modifies the program
  - Do we get the same error? No error? New errors?
3. Trace the code
  - Trapping the error means identifying where the bug exactly comes from
4. Break the code that has the problem to understand it well
5. Fix the bug
6. Test the fix

# Techniques for Debugging

1. Line by line: read rather than skim
2. Rubber duck debugging: explain the problem outloud (e.g. to a rubber duck) 
  - This stress-tests your understanding
3. Take a break and come back later
  - Note: doesn't work if you focus on something else, e.g. your phone or a different task
4. Pry
  - Load pry on each document with `require 'pry'`
  - Insert `binding.pry` to stop code execution there
5. Use a debugger
6. `tap` method: passes the calling object into a block and *returns* the object.

```
    array = [1, 2, 3]
    array.tap { |x| print x } # [1, 2, 3]=> [1, 2, 3] # `tap` returns the object (caller)
    array.select {|x| x.even? } .tap { |x| print x }
    array.map { |x| x * 3 }.map {|x| x * 2}.tap { |x| print x} # [6, 12, 18]=> [6, 12, 18]
````

- Takeaways from `tap`
  1. Callers don't need to be attached to the calling object (e.g. 5 .to_s => "5")
  2. We can call a method to a block — it passes into the new block the evaluated result of the first 