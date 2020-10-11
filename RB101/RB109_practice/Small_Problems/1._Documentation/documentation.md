 1. Locate the ruby documentation for methods File::path and File#path. How are they different?

**File::path is a public class method**: it is called on the class itself (i.e. File)

Returns the string representation of the path

```ruby
File.path("/dev/null")          #=> "/dev/null"
File.path(Pathname.new("/tmp")) #=> "/tmp"
```

**File#path is a public instance method**: it is called to an instance (i.e. File.new) of the class

Returns the pathname used to create file as a string. Does not normalize the name.

The pathname may not point to the file corresponding to file. For instance, the pathname becomes void when the file has been moved or deleted.

This method raises IOError for a file created using File::Constants::TMPFILE because they don't have a pathname.

```ruby
File.new("testfile").path               #=> "testfile"
File.new("/tmp/../tmp/xxx", "w").path   #=> "/tmp/../tmp/xxx"
```

2. What will each of the 4 puts statements print?

The documentation says: `new([year=-4712[, month=1[, mday=1[, start=Date::ITALY]]]]) → date`

Each `[]` denotes an optional parameter — which are nested in here.

This class method has 4 variables, each with its own default value:
- year: -4712
- month: 1
- month day: 1
- start: determines when (if?) the Date object uses a Gregorian or Julian calendar. The Gregorian calendar was implementd because over hundereds of years the Julian was imprecise by days.
  - Date::ITALY => date when Italy and many catholic countries implemented the gregorian calendar
    - => 1582-10-05
  - Date::ENGLAND => date when Englance and many of its colonies implemented the gregorian calendar
    - => 1752-09-14

Relevance of start and when the Gregorian or Julian calendar starts
```ruby
# Difference in days between January 1 2016 and January 1 1 using the Julian calendar only
Date.new(2016, 1, 1, Date::JULIAN) - Date.new(1, 1, 1, Date::JULIAN)
=> (735978/1)

# Difference in days between January 1 2016 and January 1 1 using the Gregorian calendar only
Date.new(2016, 1, 1, Date::GREGORIAN) - Date.new(1, 1, 1, Date::GREGORIAN)
=> (735963/1)

# Note: 15 days difference between Julian and Gregorian!

# Difference in days between January 1 2016 and January 1 1 using the calendar
# with the transition date of Italy from Julian to Gregorian
Date.new(2016, 1, 1, Date::ITALY) - Date.new(1, 1, 1, Date::ITALY)
=> (735965/1)
```

Executing the problem:

```ruby
require 'date'

# Creates a new DATE object with default values: -4712 year, day 1, month 1, 0 seconds
puts Date.new                           # Prints: -4712-01-01
=> nil

# Creates a new Date object with year 2016 and other values in their default: 0
puts Date.new(2016)                     # Prints: 2016-01-01
=> nil

# Creates a new Date object with year 2016 and month 05 (May), other values to default
puts Date.new(2016, 5)                  # Prints: 2016-05-01
=> nil

# Creates a new Date object with year 2016 month 05 (May), and month day 13
puts Date.new(2016, 5, 13)              # Prints: 2016-05-13
=> nil

# Create date object with no defaults
puts Date.new(2016, 5, 13, Date::ITALY) # Prints: 2016-05-13
=> nil
```

3. What will the code print?

I should have gone to: i) syntax and ii) calling methods

```ruby
def my_method(a, b = 2, c = 3, d)
  p [a, b, c, d]
end

my_method(4, 5, 6)
```

This will raise a syntax error because arguments with defaults should be grouped together.

This will raise an error because not enough parameters were sent to the method — 3 rather than 4
Key assumption: arguments must be in the exact order

WRONG: will return `[4, 5, 3, 6]`

This implies that `5` was passed to `b`, `c` used its default value because there weren't enough values for it and `d` (which has no default values), and `d` was passed `6`.

4. How would you search this Array to find the first element whose value exceeds 8?

```ruby
a = [1, 4, 8, 11, 15, 19]
a.bsearch { |num| num > 8 }
```

Why: documentation says that we need to pass a block and that this works with boolean values.

5. What do each of these puts statements output?

```ruby
a = %w(a b c d e)
puts a.fetch(7)                       # IndexError because it doesn't have an index 7
puts a.fetch(7, 'beats me')           # "beats me" => default value if it doesn't return a valid value
puts a.fetch(7) { |index| index**2 }  # 49 => the block is executed only when an index is out of bounds, as 7 is
```

Deduced from the documentation:

    fetch(index) → obj
    fetch(index, default) → obj
    fetch(index) {|index| block} → obj

    Tries to return the element at position index, but throws an IndexError exception if the referenced index lies outside of the array bounds. This error can be prevented by supplying a second argument, which will act as a default value.

    Alternatively, if a block is given it will only be executed when an invalid index is referenced.

    Negative values of index count from the end of the array.

6. What does this print?

```ruby
5.step(to: 10, by: 3) { |value| puts value }
```

NOTE: not said in documentation, but having `to:` and `by:` in the wrong order doesn't create an error — it still works.

7. How can we modify the code to only print the methods of the class of the calling object?

```ruby
s = 'abc'
puts s.public_methods.inspect
```

Solution: within the `Object` module it says that we need to pass the parameter `(false)` to `#public_methods`.

Note: always check withins in the class before going to its superclass in case it gets overriden.

8. How can we have min return the tw osmallest values in an `Array`?

```ruby
a = [5, 9, 3, 11]
puts a.min
puts a.min(2)
```

9. Find YAML::load_file in the documentation

The docs says that YAML is an alias of Psych, so we need to look up Psych in the Ruby API!

Once found, we verufy that Psych::load_file exists and references to YAML