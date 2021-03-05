require "minitest/autorun"
# require "minitest/reporters"
# Minitest::Reporters.use!

require_relative "car" # car is the file being tested

class CarTest < MiniTest::Test
  def test_wheels
    skip
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    assert_equal(3, Car.new.wheels)
  end

  def test_pass
  end

  def test_pass2
  end

  def test_pass3
  end
end