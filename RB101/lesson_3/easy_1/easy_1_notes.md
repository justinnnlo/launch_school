- `puts` method
  1. Passes its arguments through `to_s`
  2. Prints each element of an array in solation, rather than the entire array (why?)
- `p` method
  1. Passes its arguments through `inspect`
- `!!` turns an object into its **boolean equivalent** while `!` turns it into the contrary of its boolean equivalent
- Use `gsub` and `gsub!` to do string replacements
- A range object like `(10..100)` can be used to check whether an element is inside like `(10..100).include?(42)`
  - Note: both the `include?` and `cover?` methods can be used for the task, but have some nuances
    - `cover?`seems to rely on the first character of an object
      - ("a".."z").cover?("c".."y") # => true
      - ("a".."z").cover?("cdeylsfesfejlf0") # => true Though "0" is not included
    - `include?` seems to exactly match the character
      - ("a".."z").cover?("c".."y") # => false
      - ("a".."z").cover?("cdeylsfesfejlf0") # => false
- `append`/`prepend` are great for string mutation
- `assoc(key)` returns the key and its value as an array
  ```ruby
  flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
  flintstone.assoc("Barney") # => ["Barney", 2]
  ```
