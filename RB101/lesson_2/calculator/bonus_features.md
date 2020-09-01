# 1. Better integer validation- DONE

The current method of validating the input for a number is very weak. It's also not fully accurate, as you cannot enter a 0. Come up with a better way of validating input for integers.
<details>
  <Click to expand!>

  Option 1 - this is the easiest way to improve the method. It will handle "0" correctly.

    def integer?(input)
      input.to_i.to_s == input
    end

This isn't perfect, however, because while "0" will return true, if we input "00", this method will return false.

Option 2 - use regex. Slightly more complex, but we're using the \d regular expression to test against all digits. The ^ means start of string, the + means "one or more" (of the preceding matcher), and the $ means end of string. Therefore, it has to be an integer, and a float, like 4.5 won't match. When there's a match, the match method will return a MatchData object, which will evaluate to true. When there's no match, it'll return nil, which will evaluate to false.

    def integer?(input)
      /^-?\d+$/.match(input)
    end

Option 3 - use built-in conversion method. In Ruby, there's a method called Kernel#Integer that will convert parameters to the method into an integer object. It will, however, raise a TypeError if the input is not a valid integer, so you'll have to handle that. Note: yes, that's a capitalized method in Ruby -- fortunately, that doesn't happen often.

Note: trailing rescue is a "code smell", so be aware of that. In this specific instance, it's ok, but don't fall into a habit of suppressing errors this way.

    def integer?(input)
      Integer(input) rescue false
    end

Option 1 is really what you're expected to come up with at this point. The other two are merely to show you that there are frequently multiple ways to do the same thing in Ruby, with varying degrees of differences.
</details>

# 2. Number validation — DONE

Suppose we're building a scientific calculator, and we now need to account for inputs that include decimals. How can we build a validating method, called number?, to verify that only valid numbers -- integers or floats -- are entered?
<details>
  <Click to expand!>

  We'll create a method that tests to see whether the input is either a number or a float.

    def number?(input)
      integer?(input) || float?(input)
    end

We already have the integer? method, so all we need to do is implement a float? method.

Option 1 -- just like before, this is the easiest way to check for floats.

    def float?(input)
      input.to_f.to_s == input
    end

This method has an edge case though:

    2.6.2 :001 > '1.' == '1.'.to_f.to_s
    => false
    2.6.2 :002 > '1.'.to_f
    => 1.0

As you can see, to_f converts 1. to 1.0, which does not match the original string.

Option 2 -- use regex. This regex is similar to the regex in the integer? method, except we have to account for more possible formats. We can combine two validations to verify that the input is a valid float. The first validation verifies that there is at least one digit in the input. The second validation incorporates the * which stands for "zero or more", and the ? which stands for "zero or one". This validation can be read as "zero or more digits, followed by an optional period, followed by zero or more digits. This validation will accept all of these formats: 11.11, 11., .11, but not a period by itself. Notice that we had to prefix the . with a backslash. That is because . matches any single character in regex. By escaping it, we tell Ruby that we are looking for the actual period character.

    def float?(input)
      /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
    end

Option 3 -- use the Kernel#Float method, which is analogous to the Kernel#Integer method from earlier. Just like that method, Float also raises an exception if you don't give it a valid float, so you have to handle it. Note: trailing rescue is a "code smell", so be aware of that. In this specific instance, it's ok, but don't fall into a habit of suppressing errors this way.

    def float?(input)
      Float(input) rescue false
    end

Of the 3 options, option 1 is probably easiest to follow. Using regex seems like a good idea, until you start to run into very subtle edge cases with it.

One last thing to mention is that in programming, no matter what language you use, there's always the floating point precision problem. Be aware of that when dealing with large numbers, or working with the result of a division operation.
</details>

## 3. What if we needed to add some code after the case statement within the method? What changes would be needed to keep the method working with the rest of the program? — DONE

Answer: save the value returned by the case statement to a variable and call it at the end of the method.

## 4. Extract the program from a configuration file — DONE

There are lots of messages sprinkled throughout the program. Could we move them into some configuration file and access by key? This would allow us to manage the messages much easier, and we could even internationalize the messages.

## 5. You need to now internationalize the messages in your calculator. You have to send that configuration file to translators and call the right translation in your code. — DONE

Answer: use YAML's indentation structure to create 2-level arrays — where the language inserted defines the message to be retrieved.

    MESSAGES[lang][message]
