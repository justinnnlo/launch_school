# Ruby styling

Ruby has several styling conventions — [here's a comprehensive list](https://github.com/rubocop-hq/ruby-style-guide).


Some of the more frequently used include

- 2 spaces only: if using tabs, use your text editor's tab emulator to convert a tab into 2 spaces
  - Spacing should also be rigurously applied so that it's easy to skim
- Snake case for methods and variables: like_this (exception: constant variables, which are LIKE_THIS)
- Camel case for classes: LikeThis
- Use descriptive names for variables, methods, and classes: the name should describe what it does (e.g. `def snake_case`) rather than what it is (e.g. `def text_modifier`)
- Comments should be used within the code to explain what it does — helping someone read come is extremely important
- Spaces between the symbols of assignment ("=") and comparison ("==", ">", "<=", etc), and the objects they interact with (e.g. x = 5)

Good styling in Ruby should use the syntactic sugar allowed by the language, such as:
- `5 + 3` instead of `5.+(3)`
- no_argument instead of no_argument() when the method does not take an argument
- Tertary operators for simple if statements
  - `3 > 4 ? true : false` # Returns false because 3 is not larger than 4
- Single line if statements for simple actions
  - `print "True" if 3 > 4` # Prints nothing
- Using `attr` in classes to define get and set methods for an object's attributes
- Using `{ }` instead of `do/end` for blocks that can fit in one line

Important principles to keep in mind when coding include:
- Code that's easy to read is as if not more important than better performance
- Code should be written following OOP's abstraction principle: only show the user what's necessary to complete his task

# Ruby gems

Ruby gems refer to 
1) A collection of ruby files that perform a certain task
2) the system that publishes, organizes and lists the gems