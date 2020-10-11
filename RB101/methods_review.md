String#match

Takes in a regexp and returns a `nil` if the pattern isn't found or a truthy enumerable if it is.

Great for conditionals that require truthy values to execute.

```ruby
"KANSAS".match(/s/)
# => nil

"KANSAS".match(/s/i)
# => <MatchData "S">

puts "Matches 'S'" if "KANSAS".match(/s/i)
# => Matches 'S'
```

String#scan

This method takes in a regexp or string pattern and returns an array with strings that match the pattern.

If it doesn't match, it returns an empty array.

Default behavior
```
"hello".scan("l")
=> ["l", "l"]

"hello".scan("ll")
=> ["ll"]

"hello".scan("hll")   # One patter of "hll"
=> []

"hello".scan(/[h|ll/) # Either "h" or "ll"
=> ["h", "ll"]
```

Anomalies
```
"hi".scan("")
=> ["", "", ""]
```

String#chop

String#chomp

String#delete

String#gsub

String#replace

String#scan

String#insert

String#strip

String#squeeze