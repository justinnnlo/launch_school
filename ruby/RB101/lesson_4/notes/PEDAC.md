# What is PEDAC?

It's a problem-solving framework that follows the following steps:
1. Problem
2. Exercises
3. Data structure
4. Algorithms
5. Code

# Why should PEDAC be used?

By breaking down a problem into parts, we're reducing the complexity we face at a single moment and make the overall problem easier to solve.

A relevant meta-skill in itself is knowing when PEDAC should be used, as naturally some problems are so easy they don't need a PEDAC appraoch (e.g. capitalizing the words of a string).

# Understanding the problem

This is a crucial step — and where I think I'll have the most issues.

Here, I want to:
- Write down what are the components of the task
- Make your assumptions explicit and cross-reference them with the interviewer
- Ask questions, like these for an exercise about upcasing palindromes in a sentence
  - What does a keyword (e.g. palindrome) mean?
  - What should we do for non-string inputs?
  - Should I consider letter-case or downcase when evaluating a word?
  - Should I return the same object or a new object?
- Write down the inputs, outputs, and rules to follow

```ruby
# input: string
# output: string (not the same object)
# rules:
#      Explicit requirements:
#        - every palindrome in the string must be converted to
#          uppercase. (Reminder: a palindrome is a word that reads
#          the same forwards and backward).
#        - Palindromes are case sensitive ("Dad" is not a palindrome, but "dad" is.)

#      Implicit requirements:
#        - the returned string shouldn't be the same string object.
#        - if the string is an empty string, the result should be an empty array
```

Explicit requirements are stated in the problem definition. Implicit requirements are deduced from the problem and context (including exercises).

More examples:

1. Given a string, produce a new string with every other word removed.
  - Questions
    - Should we construct a method or a solution within the general program execution?
    - Will our input always be a string? If not, how should we treat non-strings?
    - Should we mutate the original object or create a new object for the product?
    - If it's a method, what value should we return?
    - What is every other word — ie starting from index 0 or 1?
    - How do we define a word?
      - Hypothesis: strigns delimited by spaces
  - Explicit
    - Input: string
    - Output: string
    - Remove every other word from the input
2. Sum even number rows: imagine a sequence of consequtive even integers beginning with 2. They are grouped in rows: the first with one integer, the second with two, etc. Given an integer representing the number of a particular row, return an integer representing the sum of all the integers in that row.
  - Questions
    - Do the next rows start with the number after the last number of the previous row, or do all rows start with 2?
    - What does it mean for an integer to represent a row? I.e. does 4 represent line 4 or represent line 2 because that's where the integer is found?
    - Should we assume that we will only be dealing with integer objects? If not, what should we do with other data types?
    - Should we do this as a method or within the general execution of the program?
    - What should we do with integers that don't represent a line? I.e. negative numbers, (potentially) odd numbers.
  - Explicit requirements
    - Input: integer
    - Output: integer
    - Sequence of integers that begin at 2, 
    - Each row is incrementally larger than the previous one
    - Sum all numbers in a row and return the addition
  - Implicit requirements
    - We need to create a method

## Problem exercise

```ruby
# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

# Questions:
# 1. Will inputs always be strings? How should we treat other data types?
# 2. How should we consider whitespaces? E.g. is "d d" a palindrome? Or should we evaluate words in isolation?
# 3. Should we avoid mutating the original object or not?
# 4. What is a substring?

# input: string
# output: array of strings (or empty otherwise)

# Explicit:
  # 1. Return an array with all the palindrome substrings in a string
  # 2. Palindromes should be evaluated as case sensitive (e.g. "abA" is not a palindrome)

# Implicit:
  # 1. A palindrome substring can itself contain more palindrome substrings
  # 2. Return an empry array if there are no palindrome substrings
```

# Data structure/Algorithm

The data structure is the easy part as it's usually somewhat obvious.

Devising the algorithm is less intuitive because we have to break down the problem into parts and pseudocode.

In the above example, the algorithm would be:

```ruby
# - Create a `result` variable bounded to an empty array AND a `substring` variable bounded to an empty string
# - Create a loop that is 2 levels deep: one iterates through each letter, and the other through each combination of each letter (skipping letters that cambe before)
# - Create an if conditional: if a word (`substring`) is a palindrome and longer than 2 characters, add it to `result`, otherwise go to the next one
# - Return the result variable
```

HOWEVER, what's wrong of this is that it doesn't focus on the hard part of the algorithm! Focus on that.