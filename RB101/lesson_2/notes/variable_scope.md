# What is variable scope?

A variable's scope is where it can be accessed.

Variable scopes differ by the type of variable.

- Local variables
  - Variables can be accessed inside the scopes they were defined, not scopes outside
    - This includes peer scopes


          loop do
            test = 10
            puts test # 10
          end

          loop do
            puts test # ArgumentError
          end

  - A variable accessed in an inner scope can also be reassigned
  - But when is there a new scope?
    - Within blocks — even when a block is within a method definition
      - Note: blocks passed into methods are the arguments of the method

- Constants and global variables: global/lexical scope can:
  
  1. Be created within an inner scope and accessed outside — unlike local variables
      
          loop do
            TEST = "This is a test!"
            break
          end

          puts TEST # "This is a test!"

  2. Be accessed across both leaky and self-contained scopes

          TEST = "I can appear anywhere!"

          def my_method
            puts TEST
          end

          my_method # "I can appear anywhere!"

- Class variables and instance variables: global scope **within a class**?

## Block variable shadowing

Variable shadowing is when a block paramenter has the name of a variable defined outside its scope.

This implues that within the block the outside variable cannot be accessed or reasigned.

    n = 10

    [1,2,3].each do |n|
      puts n            # 1, 2, 3
    end                 # => [1, 2, 3]

    [1,2,3].each do |n|
      n += 1
      puts n            # 2, 3, 4
    end                 # => [1, 2, 3]

# Method definition vs method invocation

Method definition is when we define a method. Method invocation is when we call a method.

# Self-contained vs leaky scopes

Block scopes are "leaky" because they allow variables defined outside of it to be accessible within the block.

But method definitions have a "self-contained" scope because only the variables assigned within it or passed as local variables can be accessed.

1. Proving self-contained scope

        test = 10

        def my_method
          puts test         # ArgumentError
        end

        my_method


2. Parameters passed to a method become local variables *of the method* — so they can't reassign a variable outside of the method scope

        test = 10

        def my_method(test)
          test += 1         
          puts test         # 11
        end

        my_method(test)     # 11, => nil
        puts test           # 10

# Method definition vs method invocation

Method definition is when we create a method (`def...end`). 

Method invocation is when we call a method. A method can be called on an object or not.

    puts "hello"  # Method invocation
    [1, 2, 3].sum # Method invocation on an object

A **method definition creates its own scope** while a **method invocation uses the scope defined by the method**.

## Methods and blocks

Blocks are used within methods. But there are nuances.

1. Nothing happens if a block is passed to a method that does not expect a block
          
        puts do
          puts "Hello"  
        end             => nil

2. When a method defines its interactions with a block, it can be executed

        def my_method
          yield         # Runs a block once
          puts "Goodbye"
        end

        my_method do
          puts "Hello"  # Hello => nil
        end             # Goodbye => nil

        def my_method
          yield         # Runs a block once
          yield         # Runs the block a second time
          puts "Goodbye"
        end

        my_method do
          puts "Hello"  # Hello => nil x 2
        end             # Goodbye => nil
