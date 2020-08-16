# String
Definition: a list of characters in a specific sequence.

Strings are recognized by being wrapped aroung single or double quotes. However, the choice of quotes creates different outputs.

Single quotes don't allow 
  i) escape sequences (e.g. \n, \t, \b) 
  ii) string interpolation: 'This is #{not} permitted', where #{not} is printed literally rather than interpolated

String interpolation allows us to include a ruby expression within a string. When we do string interpolation we do NOT need to convert the type to a string — interpolation does this automatically.

# Symbols
Symbols are created by placing a colon (:) before a word.

Symbols are different than strings in that they're inmutable/unchangeable — although not exactly?

:"Surprise, this is a symbol!"
:"This as well"
:"5 This as well"
:> #Also this
:>= #And this
:= #But not this
:5 #And definitely not this — it can't start with a number"

Symbols are **not meant to be printted on screens** because they do so literally — :hi prints *exactly* as :hi 

# Numbers

Integers: whole numbers — they can't have decimanl points.

Floats: numbers with decimal points

# nil

nil means nothing (it derives from nihil, or nothing in latin). It has no other value beyond nil.

Unlike string, numbers, and most (if not all) other data types, its boolean value is false. However, nil is *not* equivalent to the boolean value false. As proof, if you were to run `nil == false` the output is false.

# Basic integer operations

Math operations are methods. Yet due to syntactic sugar, we can call them with a laxer syntax. Thus `5 + 5 is equivalent to 5.+(5)`.

Operations between integers and floats result in floats. E.g., `5 + 5.0 = 10.0`

Integer operations that have a remainder round downward to an integer. E.g. `8/9 = 0`

# Modulo and remainder

The modulo is similar but not exactly the remainder. They output the same result when the 2 elements it operates on are positive or negative, but they treat operations with one negative number differently.

For now — just stick to the remainder method.

# String operations

String can be concatenated with other strings using the `+` operator or multiplied with integers using the `*` operator.

`"1" + "1" = "11"`
`"1" * 3 = "111"`

# Type conversion

Use `.to_i` for integers
Use `.to_s` for strings
Use `.to_f` for floats

# Basic data structures

## Arrays
- Ordered lists
- Accessed via indexes
- Can store any data type
- Data contained within `[]` separated by commas

## Hashes/dictionaries
- Information is stored in key-value pairs
- Information is unordered
- Information is accessed via keys, not indexes
- Can store any data types as keys or values
- Data enclosed within {}
- Key value pairs can be stored through either `{:key => value}` (strings or symbols) or `{key:value}` (symbols only)

# Expressions and return

An expression is anything that can be evaluated. An evaluation needs to return something, even if it´s nil or an error message

`hash rocket` — the `=>` you get back after evaluating an expression in irb/pry, followed by the value it returns