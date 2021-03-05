=begin

Input: string, number
Output: string

Problem:
- Replace each letter in the original string with another letter
- Replace each letter with another letter that is 13 positions away from the original letter
  - As there are 26 letters: position number + or - 13
  - Example:
    - A becomes N
    - Move backwards for the letters 14-26
- Note: non-alphabetical letters should NOT be changed

Examples of ordinal number conversion:

97 + 26 = 123 > 122 = 97 + 26 - 26 = 97
97 + 25 = 122 =< 122 = 122
100 + 23 = 123 > 122 = 100 + (23 - 26) = 97
105 + 22 = 127 > 122 = 105 + (22 - 26) = 101

Algorithm
- Create a new empty string and bind it to a new variable "encrypted_string"
- Iterate through each element of the str parameter
  - If the ordinal value is equal to or greater than 65 or 97 and equal to and less than 90 or 122
    - And the ordinal value + num is greater than 90 or 122, subtract 26 from the num
    - Convert the resulting num to a character
  - Append to the resulting string


- If its ordinal value is greater than 77 or 109 but less than 90 or 123, subtract 13
  - If the ordinal value is from 65 or 97 to 77 or 109, increase by 13
  - Otherwise, pass the original character
  - Append the result to the new string
=end


A closure is a chunk of code that i) can be passed around, ii) can be executed later, and iii) has access to the artefacts in scope where the closure was created.

We say that blocks form closures because they're are one of the 3 native Ruby constructs that are instances of closure alongside procs and lambdas.

Blocks:
- Can be passed implicitly to method
- Are executed on demand via `yield`
- Can access the artefacts in the binding of when it was created (see example below)

```ruby
not_in_method_scope = "hello!"

def my_method
  yield
end

my_method { puts not_in_method_scope }
# Displays "hello!"
# => nil
```

Closures are at the core of understanding local variable scope because they reveal how local variables scoping happens. They maintain access to the artefacts in scope where the closure was created. This even happens within a self-contained scope, where local variables initialized outside of it shouldn't be in scope. Yet this is what closures reveal: they can seemingly violate scoping rules because they have the binding of when they were created.

The binding is what is in scope at a particular moment. Since closures keep the binding at the point where they're created, they are able to reference that binding in other situations. Thus, something is in scope because the binding at that point can reference it. By extension, local variables have different scoping rules in closures, self-contained scopes and leaky scopes because of how the binding stores these variables in each of these circumstances.


At a more technical level, a binding is an object of class `Binding` that stores the artifacts that are in scope at that moment — it *binds* a name to a memory reference. For example, in line 3 below we see how the local variable `test` is stored in the array returned by `binding.local_variables`. Additionally, line 57 and 58 show how `binding.eval("test")` can reference the same object pointed to by `test`.
```ruby
test = "Hello"                  # 5
binding                         # => #<Binding:0x00007fec22961020>
binding.local_variables         # => [:test, :__, .....]
binding.eval("test")            # => "Hello"
binding.eval("test").eql?(test) # => true
```