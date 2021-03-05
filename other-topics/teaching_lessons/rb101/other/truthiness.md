# What is true or false?

As (almost) anything in Ruby, `true` and `false` are objects with classes.

`true` is an object of `TrueClass` and `false` is an object of `FalseClass`. As with any classes, `BasicObject` is the first/oldest ancestor.

## `false` and `nil`

A small caveat: `false` **is not** `nil`.

`false` represents a boolean state whereas `nil` represents the state of nothing — of being empty. This can be proven with `false.nil?`, which returns `false`.

What they do share is a common boolean value. They're both unique in that they're false. `!!nil == !!false` returns true, because both have a value of `false`.

# Accesing methods

`true` and `false` share the same methods. This can be proven with `true.methods == false.methods`, which returns `true`.

To view their methods, input `true` or `false` followed by `.methods`.

# to_s

Like all other data types, we can convert `true` and `false` into `String` objects. This can be done via the `to_s` method, which returns the same text as a string.

For example, `true.to_s` returns the string `"true"`.

# Conditional logic with truthiness

Conditionals always work with truthiness, whether they're explicit about it or not. `if x > 7` ultimately evaluates to `if true` or `if false`.

Important caveat: if you make a conditional with `true` or `false`, the conditional always evaluates the statement the same way.

For example, `while true` will always create a new loop — because `while` has a value of `true`. Inversely, if we do `while x > 7` the loop can stop without an explicit return if x first has a value larger than or equal to 7 at the start — before the loop starts.

So beware of using conditionals purely with `true` or `false` — and when you do, make sure you avoid an infinite loop by establishing under what conditions to break it.

## Truthiness with other data types

What does `while 5` mean and what does it lead to?

This is like saying: `while true` because 5 has a boolean value of `true`. Similarly, `while "false"` is equivalent to `while true` because the `String` `"false"`, as with any `String`, has a boolean value of `true`.

This applies to all objects — from strings to arrays and hashes to classes that are not native data types.

## To be or not to be

Being *considered* `true` does not mean *being* `true`.

Pop up pry or IRB to prove it with `5 == true`. It's false because even though 5 is *considered* true it ain't the *object* `TrueClass`.

## Truthiness with methods

Conditionals can be executed based on the value returned by a method. It all depends on the value of the evaluated expression.

# Logical operators

Operators like `||` and `&&` return a boolean value.

## Logical operations and order precedence

Math has PEMDAS, Ruby has the wider order precedence. Make sure to use parentheses to avoid errors.

For example:

    num = 5
    => 5
    num < 10 && num.odd?
    => true
    num < 10 && num.even?
    => false

  What's going on here? Because `<` has a higher order of precedence than `&&`, it's being evaluated as `(num < 10) && (num.odd?)`. 

  If inversely `&&` had a higher order of precedence, Ruby would evaluate the statement as `num < (10 && num.odd?)` — which would raise an error.

## Short circuiting

`&&` and `||` stop evaluating an expression once it can guarantee the value it's going to return. This is called **short circuiting**.

For example, what does `false && 3/0` return — `false` or a `ZeroDivisionError`?

Because of short circuiting, Ruby evaluates only `false` — because only with that it can guarantee that it'll return `false`.

Inversely, `true || 3/0` returns `true` because only a single true statement is needed to return that value.

## Applying short circuiting

We can use short circuiting and the implicit boolean values to make more succinct code. This is helpful if we want to evaluate a conditional with a method but are concerned the argument could be nil (and thus return an error when the method evaluates it).

For example

  num = nil

  if num && num.odd?
    return "Odd number"
  elsif num && num.even?
    return "Even number"
  else
    return "Something's wrong with the input!"
  end

In each of the statements above, we're avoiding the method error of `nil.odd?` of `nil.even?` by short circuiting — the method **stops at num**.
