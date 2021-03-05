# What is inheritance?

Inheritance is when a class (the subclass) inherits behavior from a superclass.

Why is it great? Because it helps us avoid repetitive code! Remember: DRY.

## Setting inheritance

A class can be made to inherit from another class at the top of the class definition

    class ArrayLike < Array
    end

Here, the `ArrayLike` class is inheriting the behavior of `Array`.

## Method preference

A subclass and its superclass can have methods with the same name but different content. Here, the subclass' method prevails because of the principle of specificity — the more specific subclassis applied to that class. (Note: this has parallels to HTML and CSS and specificity for setting styles).

## `super` and retrieving conflicting methods from superclasses

The `super` method is useful when you have methods with the same name but different content in a subclass and superclass. Within the subclass' method, you can call super to call the method of the superclass.

    class Animal

      def hi
        "Hi!"
      end
    end

    class Monkey < Animal
      def hi
        super + " I'm a monkey!"
      end
    end

**When would we use it?**
- A good case study is like the above — when we want to call a superclass' method but add extended functionality to it.
  - A common approach is to call `super` in `initialize` to apply all of the instance variables of the superclass to the more detailed subclass' `intitialize`

### `super` and arguments
- `Case 1`: If `super` expects but doesn't receive any arguments, it automatically forwards the arguments that were passed to the method from which `super` was called.
    class Animal
      attr_accessor :name

      def initialize(name)
        @name = name
      end
    end

    class Monkey < Animal
      def initialize(color)
        super
        @color = color
      end
    end

    Manuela = Monkey.new("Brown")
    => #<Monkey:0x00007fc40425f5b0 @name="Brown", @color="Brown">

- **Case 2.a**:If `super` expects and receives arguments, it passes those arguments

    class Animal
      attr_accessor :name

      def initialize(name)
        @name = name
      end
    end

    class Monkey < Animal
      def initialize(name, color)          # Change
        super(name)                        # Change
        @color = color
      end
    end

    Manuela = Monkey.new("Marce", "Brown") # Change
    => #<Monkey:0x00007fc404187520 @name="Marce", @color="Brown">

**Case 2.b**: `super` with 1 argument and 2 instance variables in the superclass `ìnitialize` method
    class Animal
      attr_accessor :name

      def initialize(name)
        @name = name
        @age = 0
      end
    end

    class Monkey < Animal
      def initialize(name, color)          # Change
        super(name)                        # Change
        @color = color
      end
    end

    Manuela = Monkey.new("Marce", "Brown") # Change
    => #<Monkey:0x00007fbe951dba90 @name="Marce", @age=0, @color="Brown">

- If `super` does *not* expect an argument, it has to be initiated as `super()`to pass no arguments and avoid `ArgumentError`

**Case 3**: `super()` expects and receives no arguments — so it needs parentheses or will raise an error
    class Animal
      attr_accessor :name

      def initialize
        @age = 0
      end
    end

    class Monkey < Animal
      def initialize(color)       # Change
        super()                   # Change
        @color = color
      end
    end

    Manuela = Monkey.new("Brown") # Change
    => #<Monkey:0x00007fbe951619c0 @age=0, @color="Brown">