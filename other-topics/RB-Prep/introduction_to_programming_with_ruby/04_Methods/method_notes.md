# What are methods?

Methods are pieces of reusable code. They can be applied to either an instance of a class or on the class itself. Methods are class-specific — you can't apply a method to a class or class instance that doesn't have said method.

In other programming languages, methods are sometimes called procedures.

Methods are created within `def` and `end`.

Methods are **not** functions. Strictly speaking, a function cannot be applied to an object while a method can be.

A method is **called** or **invoked** by typing its name and passing its arguments or parameters, if its needed.

## Arguments || parameters

Arguments or parameters are used **when we need to use data outside the scope of the method definition**.

Like variable names, method names should be descriptive to make reading the code easier.

We can define a method with default parameters. This involves assigning a parameter a value that is used by the method unless you pass an argument that overrides it. For example, `def test(a=5)` means that the local variable `a` in the method `test` will have a default value of 5.

### Optional parentheses

The parentheses that envelop the arguments are optional. For example

~~~
test = "Hello"
test.index "H" # Returns 0
test.slice 1,3 # Returns "ell"
~~~

# Local variable scopes in method definitions

A method definition creates in own scope outside of the **regular execution** of the program.

Being outside the regular execution explains why
  - Local variables within the method can't be referenced outside of it
  - Local variables within a method definition cannot access data outside of the method definition (and why they need arguments if it needs some data)

a = 5 # Value of a within the regular execution of the program

def some_method # Scope of some_method
  a = 3 # a = 3 in the method's scope because it's outside of the regular executio of the program
end

puts a # 5

## Local variable scope: method definitions vs method invocations with blocks

The distinction is that local variable in the regular execution of the program are accessible within method invocations with blocks, assuming they're at a higher scope. 

In contrast, local variables are not available in method definitions **because they're outside the regular execution of the program.**

# Mutating the caller

This means that an argument passed into a method is permanently changed.

How is this possible if variables within a method are not in the same scope as the regular execution?

Only if we **perform an action on the argument** inside the method that mutates the caller.

~~~
# Main takeaway: reassignment is subject to scopes.
a = 1

def plus_one(a)
  a += 1
end

plus_one(a) #Returns 2
puts a # 1 because a+=1 was performed within the method's scope — not in the regular execution of the program.
~~~

~~~
a = [1,2,3] 

def pop_last(arr)
  arr.pop # .pop is a method that mutates the caller, which happens even from within a method scope
end

pop_last(a) # Returns 3
p a # Prints and returns [1, 2]
~~~

# puts vs return

puts prints the evaluated expression and returns nil. In contrast, return stops the execution of the scope of the program and returns the evaluated expression in the last line unless an explicit return came before.

Note that an explicit return is not required — if there isn't any, it returns the evaluated expression of the last line.

# Chaining methods

Method chaining is executing multiple methods in a single call. For example:

`"Hello".upcase.downcase.capitalize`

Is in practice

`"Hello".upcase` then `"HELLO".downcase` and finally `"hello".capitalize` which returns `"Hello"`.

In sum: method chaining evaluates an expression from left to right and using the value of the expression returned by the previous method.

IMPORTANT: if at any point the method chain returns nil or an exception, it breaks the whole chain.

# Method calls as arguments

Ruby allows us to use method as arguments.

~~~
def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

subtract(add(5, 4), add(3,2)) # 9 - 5 = 4
~~~