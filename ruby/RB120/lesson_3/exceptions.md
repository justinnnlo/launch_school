# What is an exception?

An exception(al) state of the code. If you don't take care of it the program will crash and return an error.

This is how Ruby tells us that the code is behaving unexpectadly.

# Exception class hierarchy

`Exception` is the ancestor of all other exception classes — they descend from it.

There are 33 other exception classes besides `Exception`. They include all the error types that we usually encounter — `NameError` and its subclass `NoMethodError`; `StandardError`, `SyntaxError`, etc.

## Digging deep into class heirarchies

All exceptions descend from `Excpetion`. `Exception` is itself a child of `Object` class and by extension `BasicObject`.

# Handling errors

Some errors, namely most of the descendents of `StandardError`, are safe to handle. This means that the program would not crash if the error is executed.

However, some exceptions should allow out program to crash because they're serious — like `NoMemoryError`, `SyntaxError`, and `LoadError`.

Handling many errors can be counter productive by hiding potentially critical problems that threaten the stability of the program.

If you handle an error, be very specific of how you do it! The actions you can do include:
  - Logging an error
  - Sending an email to the administrator
  - Displaying an error message to the user

## How to handle an exception/exceptional state

`begin/rescue` blocks handle errors and keep the program from crashing if they appear. If the error it's handling appears the code under `rescue` is executed (otherwise, it isn't).

In the code below, we rescue any type of `NameError` and its descendents. It will then output the message assocuated with the exception object.
```ruby
begin
                           # Code at the risk of crashing
rescue NameError => errors # Stores the exception object in errors
  puts errors.message      # What action to take
end
```

We can rescut many types of errors within a `begin` block.
```ruby
begin
  # Code at the risk of crashing
rescue NameError
  # What action to take
rescue NoMethodError
  # What action to take
rescue SyntaxError
  # What action to take
end
```

And we can put multiple error classes in the same line if we want to execute the same code when more than one of them is raised.
```ruby
begin
  # Code at the risk of crashing
rescue NameError, NoMethodError, SyntaxError
  # What action to take
end
```

Caveat: avoid rescuing `Exception`! As the ancestor of all error classes, this would rescue all errors.

# Raising exceptions manually

Ruby allows us to raise exceptions via the `Kernel#raise` method. Some of the syntaxes of the method include:

```ruby
raise TypeError.new("Something went wrong!")
raise TypeError, "Something went wrong!"
raise("Something went wrong!")  # By default raise resorts to RuntimeError
```

Exceptions can also occur within methods
```ruby
def validate_age(age)
  raise("invalid age") unless (0..105).include?(age)
end
```

Caveat: exceptions raised manually can also be handled — like Ruby's native exceptions.

```ruby
begin
  validate_age(age)
rescue RuntimeError => e
  puts e.message # => "invalid age"
end
```

# Creating custom exceptions

We can create custom excpetions just as we can create any Ruby class.

```ruby
class ValidateAgeError < StandardError; end

def validate_age(age)
  raise ValidateAgeError, "invalid age" unless (0..105).include?(age)
end

begin
  validate_age(age)
rescue ValidateAgeError => e
  # Action
end
```