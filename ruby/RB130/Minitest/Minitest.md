# Minitest vs Rspec

Minitest is the default testing library of Ruby.

Minitest uses Ruby syntax for testing. This contrasts to the popular Rspec, that approximates English syntax. The difference is that Rspec is a Domain Specific Language (DSL) — which makes Rspec more complicated than the more straightforward Minitest.

Yet that aside, Minitest and Rspec have very similar functionalities — it's like Rspec, but in Ruby rather than without magical syntax.

# Testing vocabulary

- Test suite: the entire set of tests for the program
- Test: the description of a situation being tested
  - Example: this test makes sure you get an error message if your password does not meet the security standards
- Assetion: the verification step that confirms that the data returned by the test is what you were expecting
  - Note: you can have 1 or more assertions per test (i.e. description)

# Basics of testing

We first need to create the Ruby file with the code we'll test:
```ruby
# car.rb
class Car
  attr_accessor :wheels

  def initialize
    @wheels = 4
  end
end
```

We then need to create a second Ruby file with the tests and assertions we want to conduct.

```ruby
# car_test.rb
require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end
```
- `require 'minitest/autorun'`: include the `minitest` RubyGem
- `require_relative "car"`: states that `car` is the Ruby file (i.e., implicitly `car.rb`) being tested
- `class CarTest < MiniTest::Test`: define a `CarTest` class that inherits from `MiniTest::Test` class — i.e., class `Test` found in `MiniTest` module that contains the methods that allow us to test
  - Within `CarTest` we can write tests by defining instance methods that start with `test_` — this tells `minitest` that these methods are individual tests that need to be run
- `def test_wheels`: definition of a test
- `car = Car.new`: instantiation of a `Car` object and binding with `car` local variable
- `assert_equal(4, car.wheels)`: `assert_equal()` is the assertion — what we are trying to verify
  - The first parameter (`4`) states the expected value returned
  - The second parameter (`car.wheels`) states the test or value being tested
  - If there's an error: `minitest` will save the error and report it at the end of the test run

Additionally, we can include the Minitest-Reporters gem to improve Minitest's UI by adding after `require minitest/autorun`:

```ruby
require minitest/reporters
Minitest::Reporters.use!
```

## Successful tests
This is how a successful test suite looks like: `.` means there was nothing wrong — and it has no failures and errors.
```
# Running:

.

Finished in 0.000981s, 1019.3682 runs/s, 1019.3682 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

## Unsuccessful tests
This is how a successful test suite looks like: `F` means there was at least one failure — and it has no failures and errors.

`CarTest#test_wheels [car_test.rb:8]` is the test that failed, `Expected: 3` the value it expected and `Actual: 4` the value it returned.
```
# Running:

F

Finished in 0.001643s, 608.6427 runs/s, 608.6427 assertions/s.

  1) Failure:
CarTest#test_wheels [car_test.rb:8]:
Expected: 3
  Actual: 4

1 runs, 1 assertions, 1 failures, 0 errors, 0 skips
```

## Skipping tests

We can skip a test by writing `skip` right below the instance method definition of a test.
```ruby
  def test_wheels
    skip
    car = Car.new
    assert_equal(4, car.wheels)
  end
```

If the test suite with a skipped test is successful, it'll display an `S` for skipped.

# Expectation syntax

In the code above we used assertion syntax — as in `assert_equal(4, car.wheels)`.

A more abstract, human-readable syntax included in `minitest` is called expectation syntax. Expectation syntax is a more simple DSL than Rspec.

- Tests are grouped in `describe` blcoks
- Individual tests are replaced with the `it` method
- Assertions are replaced by expectation matchers

Therefore, the above test is replaced with:
```ruby
describe "Car#wheels" do
  it "has 4 wheels" do
    car = Car.new
    car.wheels.must_equal 4 # Expectation matcher
  end
end
```

# Assertions

In the example below we used `assert_equal` to determine if a test resulted in a specific value returned.

But assertions can cover almost any case: whether an error is raised, whether something is truthy, etc. [See the full list of assertions here](http://docs.seattlerb.org/minitest/Minitest/Assertions.html).

Based on the `Car` class
```ruby
class Car
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end
end
```

We can make the following tests

## Does the car exist?

`assert()` checks whether the parameter is truthy.
```ruby
  def test_car_exists
    assert(Car.new)
  end
```

## Are the values equal?

`assert_equal()` checks whether the 2 parameters are the same
```ruby
  def test_wheels
    assert(4, Car.new.wheels)
  end
```

## Is the return value nil?

`assert_nil`
```ruby
def test_no_faults
  assert_nil(Car.new.faults)
end
```

## Does it raise an error?

`assert_raises`
```ruby
def test_raise_initialize_with_arg
  assert_raises(ArgumentError) do
    car = Car.new(name: "Joey")
  end
end
```

# Refutations

Refutations are the opposite of assertions. They refute rather than assert. Every assertion has a corresponding refutation. `assert` has the opposite `refute`, `assert_equal` has the opposite `refute_equal`, etc.

# SEAT approach

- "S": set-up the necessary objects
- "E": execute the code against the objects we're testing
- "A": assert the results of the execution
- "T": tear down and clean up any lingering artifacts

This contrasts with the approach we were taking above due to the 1st and 4th steps. We were instantiating a new object in every assertion and weren't cleaning anything.

We can set-up objects via the `setup` instance method, which is a Minitest constructor method.

```ruby
class CarTest < MiniTest::Test
  def setup
    @car = Car.new
  end
end
```
In the above example, any new instance method created to perform tests would be able to access the `@car` instance variable that points to an instance of `Car`. Note that using local instad of instance variables wouldn't work — they wouldn't be accessible by instance methods doing the testing.

**`#setup` is executed befre running every test**.

For the clean-up, minitest has the **`#teardown` method that is called after running each test**. Though in this example with `Car` objects it isn't necessary, it's helpful when you need to cleanup files, log information or close database connections.

# Testing equality

How does `assert_equal` test for equality? It invokes the `==` method on the object.

If you want to test for strict object equality, `assert_same` does the trick.

Thus, in order to use `assert_equal` correctly using custom classes we need to define custom `==` methods in the file that is being tested.

# Code coverage

Code coverage is how much of the program code is tested by a test suite. Given that in `todo-list_test.rb` we've tested all the instance methods we can say that we've achieved 100% coverage. Note that code coverage includes public, private, and protected methods.

Code coverage is a metric to measure code quality — though it isn't foolproof.

A code coverage tool is the `simplecov` gem, which measured the code coverage percentage being tested.

To use `simplecov`, write at the top of the file:

```ruby
require 'simplecov'
SimpleCov.start
```

`simplecov` creates a new directory called `coverage` and within it stores an HTML document called `index.html` with the coverage results.