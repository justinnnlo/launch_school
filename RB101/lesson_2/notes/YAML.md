# What is YAML?

YAML (YAML Ain't Markup Language) is a file format to **store and transmit data**. It does nothing else — it has no built-in commands.

## YAML structure

YAML is ordered via indentation. If we want to next YAML data, we need to put the child elements with a 2 space indentation relative to the parent.

    parent:
      children: "I'm the kid!

But YAML data is not sensitive to whitespaces. Thus, we can still order the data for better styling and legibility.

    parent:
      child:       I'm the kid!
      sibling:     I'm his brother!
      half-sister: I'm sure you can guess...

## Variables in YAML

Variables are defined by text preceded by a colon.

    variable1: 25
    variable2: "Second"
    variable3: [5, 4, 3]

## Data structures

The data structure is automatically set when loaded into Ruby — but always needs to be around quotes. Otherwise, it'll either think there's a `TypeError` or, if it's a string, that you're passing an uninitialized variable.

    YAML.load(45)                 # => TypeError, YAML needs inputs within quotes!
    YAML.load("45").class         # => Integer

    YAML.load([1, 2, 3]).class    # => TypeError, YAML needs inputs within quotes!
    YAML.load("[1, 2, 3]").class  # => Array
    
    YAML.load(hello)              # => NameError: uninitialized constant hello
    YAML.load("hello")            # => "hello"
    YAML.load("I'm 45").class     # => String

It also seems like it's indifferent between double and single quotes:

    YAML.load("[1, 2, 3]").class # => Array
    YAML.load('[1, 2, 3]').class # => Array

## String interpolation in Ruby with YAML

If you try to interpolate a string from YAML into Ruby, you'll probably face some challanges:

    # test.yml
    name: "Jose"

    # test.rb
    require 'yaml'

    name = YAML.load_file("test.yml")
    puts "My name is #{name}"
    

## Newlines in YAML

There are 2 ways to have newlines in YAML text

    version1: |
               Each of these
               Newlines
               Will be broken up
    version 2: Each of these
               Newlines
               Will be broken up

Note that due to YAML's indentation structure the content of each of these variables has to be in a deeper indentation than its parent. For example, these would not work:

    version1: |
    Each of these
    Newlines
    Will be broken up
    
    version 2: Each of these
    Newlines
    Will be broken up

They will instead return a `Psych::SyntaxError` because it `coukd not find expecred ':' while scanning a simple key`.

## How does Ruby work with YAML?

Add `require 'yaml'` at the top of the file.

Include YAML files with `YAML.load_file(<file_name>)` or YAML text directly with `YAML.load(<YAML_text>)`.