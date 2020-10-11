
# `format` types

`#format` uses the `type` variable to manipulate the input according to the data type that's specified.

The main types are:
- String: `s` — though it can also treat arrays and hashes (as strings)
- Integer: `d` of `i`
- Float: `f`

```ruby
format("%s", ["Hello", "I'm", "trying"]) # prints ["Hello", "I'm", "trying"]
=> "[\"Hello\", \"I'm\", \"trying\"]"
puts format("%s", ["Hello", "I'm", "trying"]) # prints ["Hello", "I'm", "trying"]
=> nil

format("%s", { 1 => 2 } )
=> "{1=>2}"
puts format("%s", { 1 => 2 } ) # prints # {1=>2} as it conceals the ""
=> nil

format("%s", "Hello!")
=> "Hello!"

puts format("%s", "Hello!")   # prints Hello! as it conceals the ""
=> nil

format("%d", 356)
=> "356"

format("%i", 356)
=> "356"

format("%d", 356.6)                # Integers round downwards
=> "356"

puts format("%d", 356.6)           # prints 356 as it conceals the ""
=> nil

format("%f", 356.6)
=> "356.600000"

puts format("%f", 356.6)          # prints 356.600000
=> nil
```

Pretty simple stuff so far.

# Width and precision

Precision specifies the number of characters from the input that are shown. It does so via `.[integer]`.

Width specifies the minimum number of characters to be shown. It does so via an integer before precision.

- When precision >= width: works as normal — width specifies a minimum, not a maximmum
- When precision < width: It prints all the characters of the input and then prints the delta between input.length and width

Let's go back to the examples from types.
- How can we print the float 356.6 without 5 0's at the end?
  - `format("%.1f", 356.6)` => "356.6"
- How can we print the integer 356 with a `.0` at the end?
  - `format("%.1f", 356)` => "356.0"
- How can we print `{ 1` from the hash `{ 1 => 2 }`?
  - `format("%0.3s", "{ 1 => 2 }")` => "{ 1"


Exercises
- Shorten a name to 3 characters
```ruby
name = "Jose"
format("%.3s", name) #=> "Jose"
```
- Put a space before the shortened name

- Round an amount of money to dollars and cents. It should always be the same length.
```ruby
amount = 38.2340
format("$ %.2f", amount) # => "$ 38.23"

# format adds a "-" for negative numbers by default
amount = -38.2340
format("$ %.2f", amount) # => "$ -38.23"
```

- Display the clock time
```ruby
format("%02d:%02d", 18, 9) # "18:09
format("%02d: %02d", 18, 9) # "18: 09 => because of the space after the colon
```

# Flags

Flags are instructions that modify the behavior of the format method.

- All
  - "-": left justifies the result (rather than the default right justify)
- Numeric types
  - 0: replaces the default space for a 0
  - +: for numeric numbers it adds its positive or negative symbol
  - Whitespace: adds a " " when positive and a "-" when negative

```ruby
#Left justifying a text with an extra whitespace
format("%-6s", "Hello")
=> "Hello "

# Replacing whitespaces for 0's in numeric types
format("%6d", 356)
=> "   356"
format("%06d", 356)
=> "000356"

# Adding the value sign to numeric types
format("%+06d", 356)
=> "+00356"  # Note how the "+" IS inclusive of the width count of 6 — hence why 5 numeric characters
format("%+06d", -356)
=> "-00356"

# Display the positive numeric value sign with a space
format("% 06d", -356)
=> "-00356"
format("% 06d", 356)
=> " 00356" # " " replaces the "+"
```


# Old notes

`format(format_string, arguments_to_be_formatted)`

`“%[flags][width][.precision]type”`

Type: what is the type of the input?
- `d` for decimal or `i` for integer
- `f` for float
- `s` for string
- Others include `e` or `g` for exponential notation, and more

Precision: controls the number of characters to be displayed and written with a period and integer (`[.precision]`)
- Controls the number of characters displayed
- It behaves differently according to the field type
  - Float places ir after the decimal point: `format("%.2f", 3.14159) => 3.14`
  - Integer places it for total decimal places: `format("%.2d", 3.14159) => 03`
    - Rounds up to integers and puts a 0 in front if .2 precision
  - String uses it as maximum characters: `format("%.2s", "potatoe") => "po"`

Width: an integer that specifies the minimum number of characters to output — and by default with a fill of spaces
- format("%2s", "p") => " p"
- format("%2d", 3.14) => " 3"
- format("%2f", 3.14) => "3.140000"

Flags: characters that modify the behavior of the format
- Flag characters:
  - 0: pads with 0's for numeric types
    - format("%08.5f", 3.145) => "3.145000" WRONG, should be "03.14500"
  - Whitespace: adds a "-" when negative and leaves a whitespace (" ") when positive
    - format("% d", 356) => " 356"
    - format("% d", -356) => "-356"
  - +: adds a sign to numeric types
    - format("%d, 356) => "+35"
    - format("%d, -356) => "-35"
  - -: left justifies the result within its width
    - format("%-8.5f", 3.14) => "3.14000 "
    - format("%8.5f", 3.14) => " 3.14000"
  - *
  - "#"

How is precision and width different?


format("%02d:%02d", 123, 3)


format variables
  - Type: what's the data type of the input to the method?
  - Precision
  - Width
  - Flag


