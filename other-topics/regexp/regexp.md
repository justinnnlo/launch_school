# What is regexp?

Regexp (regular expressions) are patterns that we can use to match strings.

# Syntax

Regexp are written within to `/` characters.

# Pattern concatenation

Patterns are concatenated to form a larger pattern by putting them next to each other. `/cat/` is a concatenation of `c`, `a` and `t`.

Key insight: **patterns, not characters, are the building blocks of regexp**

## Meta/special characters

`?`: optional

`^`: start of line

`$`: end of line

`\A`: start of string

`\z`: end of string without escape characters

`\Z`: end of string with escape characters

`^`: not — ie not this character or group of characters

`. `; any character

`|`: or logic

### Matching meta characters

To match in a regexp the literal meta characters, we need a backslash `\` before the character.

```ruby
"KANSAS".scan(/./)
# => ["K", "a", "n", "s", "a", "S"]

"KANSAS".scan(/\./)
# => []
```

## Character classes

### Character sets

A set matches a single occurrence of any character within brackets.

```ruby
"Four score + seven".scan(/[e+]/)
# => ["e", "+", "e", "e"]

"Four score + seven".scan(/[re+]/)
# => ["r", "r", "e", "+", "e", "e"]
```

Example: validating an input as either `n`, `N`, `y` or `Y`.

```ruby
input = "y"
puts "Correct input" if input.match(/[nNyY]/) # Prints "Correct input"
```

Character sets can be concatenated with other patterns to, for example, match a capitalized and lowercase string — but not in uppercase

```ruby
puts "MATCH" if "MATCH".match(/[Mm]atch/)
# => nil
puts "match" if "match".match(/[Mm]atch/)
# => nil, prints match
puts "Match" if "Match".match(/[Mm]atch/)
# => nil, prints Match
```

### Range of characters

Within a natural sequence of alphabetical or numeric characters we can use a range within a character set: `[a-z]` or `[e-g]`.

Outside a character set ranges do not work as regexp searches for the literal concatenation.

```ruby
"123FabfABE".scan(/[a-f]/i)
# => ["F", "a", "b", "f", "A", "B", "E"]
"123FabfABE".scan(/a-f/i)
# => []
"a-f".scan(/a-f/)
# => ["a-f"]
```

Warning: do not mix upper and lowecase characters in a range! It creates a range that includes non-alphabetic characters.

### Negation

Within a character class we can negate a character or set of characters with `^`.

`/[^e]/` matches all characters except `e` and `/[^a-z]/` matches all characters except lowercase alphabetical characters

### Metacharacters and character classes

Something like `/[*!abc123]/` works because within a character class there's a reduced number of metacharacters.

Valid metacharacters within character classes are: `[`, `]`, `-`, `\`, `^`

### Structuring character sets

It's good practice to group characters in a set by type — e.g. `[*!abc123]`

It's best practice, for readability, to place the non-alphanumeric characters first.

## Options

After the second `/` character we can place options to modify the regexp.

A useful one is `i` to make an alphabetical search case insensitive.

```ruby
"KANSAS".scan(/"s"/)
# => []

"KANSAS".scan(/"s"/i)
# => ["S", "S"]
```

# Matching control character escapes

Control character escapes in strings represent characters that don't have a visual representation. These include: newlines (\n), carriage returns (\r) and tabs (\t)




(a...b).select { |n| n == n.to_s.chars.map.with_index(1) { |e, i| e.to_i ** i }.reduce(:+) }


Input: string
Output: string

Problem: add the number of points per word and return the word with the highest points

Algorithm
- Initialize an empty hash = {}
- Split the string, iterate through each
  - hash[word] = points
  - points = map of word where its each char's ord - 96
- Return hash.max[0]

