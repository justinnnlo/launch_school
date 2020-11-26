require "byebug"

def mutate_me(collection, &block)
  return collection if !block_given?

  collection.each_with_index do |e, i|
    collection[i] = block.call(e)
  end
end

# arr = [1,2,3]
# p mutated_arr = mutate_me(arr) { |el| el + 5 } # [6,7,8]
# p arr.object_id == mutated_arr.object_id # true

# p mutate_me(['a','b','c'])
# p mutate_me(['a','b','c']) { |el| el.upcase } # ['A', 'B', 'C']

p mutate_me([[1,2], [2,3], [3,4], 'a', 'b', 'c']) do |el|
  byebug
  el.is_a?(Array) ? el.reverse : el
end # [[2, 1], [3, 2], [4, 3], "a", "b", "c"]
[1, 3, 5, 7, 9, 11].all? { |obj, *args| obj.send(:odd?, *args) }


# player_test.rb
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'player'

class PlayerTest < MiniTest::Test

  def setup
    @initial_health = 100
    @player = Player.new("john", @initial_health)
    @default_player = Player.new("jane")
  end

  def test_name_is_capitalized
    assert_equal(@player.name, 'John')
  end

  def test_health
    assert_equal(@player.health, @initial_health)
    assert_equal(@default_player.health, 50)
  end

  def test_to_s
    assert_equal(@player.to_s, "I'm John with health = 100.")
    @player.health = -1
    assert_equal(@player.to_s, "I was John, now I am dead :(.")
  end

  def test_raises_error
    @player.health = -1
    assert_raises(NoMethodError) { @player.boost }
    assert_raises(NoMethodError) { @player.hurt }
  end

  def test_boost
    @player.boost
    assert_equal(@player.health, @initial_health + 20)
  end

  def test_hurt
    @player.hurt
    assert_equal(@player.health, @initial_health - 10)
  end

  def test_dead?
    @player.health = -1
    assert(@player.dead?)
  end
end