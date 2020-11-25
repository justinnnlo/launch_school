require 'minitest/autorun'
# require "minitest/reporters"
# Minitest::Reporters.use!
# require 'simplecov'
# SimpleCov.start

require_relative 'todo-list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    list = @list.clone
    assert_equal(@todo1, list.shift)
    assert_equal(@todos[1..2], list.to_a)
  end

  def test_pop
    list = @list.clone
    assert_equal(@todo3, list.pop)
    assert_equal(@todos[0..1], list.to_a)
  end

  def test_done
    assert_equal(false, @list.done?)
  end

  def test_add_raise_error
    assert_raises(TypeError) { @list.add("hi") }
    assert_raises(TypeError) { @list.add(1) }
    assert_raises(TypeError) { @list.add(["hi"]) }
  end

  def test_shovel
    list = @list.clone
    todo = Todo.new("Hi")
    assert_equal(@list.to_a + [todo], list << todo)
  end

  def test_add
    list = @list.clone
    todo = Todo.new("Hi")
    assert_equal(@list.to_a + [todo], list.add(todo))
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) { @list.item_at(100) }
  end

  def test_mark_done_at
    test = @todo1.clone
    test.done!

    assert_equal(true, @list.mark_done_at(0))
    assert_equal(test, @list.item_at(0))
    assert_raises(IndexError) { @list.mark_done_at(100) }
  end

  def test_mark_undone_at
    todo = @todo1.clone
    todo.undone!

    assert_equal(false, @list.mark_undone_at(0))
    assert_equal(todo, @list.item_at(0))
    assert_raises(IndexError) { @list.mark_undone_at(100) }
  end

  def test_done!
    test = @list.clone
    test.mark_done_at(0)
    test.mark_done_at(1)
    test.mark_done_at(2)
    assert_equal(test, @list.done!)

    @list.mark_undone_at(0)
    @list.mark_undone_at(1)
    @list.mark_undone_at(2)
  end

  def test_remove_at
    test = @list.clone
    assert_equal(@list.item_at(0), test.remove_at(0))
    assert_equal(@todos[1..2], test.to_a)
    assert_raises(IndexError) { @list.remove_at(100) }
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s2
    @list.mark_done_at(1)
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s3
    @list.mark_done_at(0)
    @list.mark_done_at(1)
    @list.mark_done_at(2)
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    assert_equal(@list, @list.each { |n| n })
    test = []
    assert_equal(test, @list.each { |todo| test << todo }.to_a)
  end

  def test_select
    assert_equal(@list.all_done, @list.select { |todo| todo.done? })
  end
end