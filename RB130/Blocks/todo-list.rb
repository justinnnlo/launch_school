require "byebug"

# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

puts todo1
puts todo2
puts todo3

todo1.done!
todo2.done!
todo3.done!

puts todo1
puts todo2
puts todo3

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    todo.class == Todo ? @todos << todo : (raise TypeError.new "Can only add Todo objects")
  end
  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def done!
    @todos.each { |todo| todo.done! }
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    @todos[index].done!
  end

  def mark_undone_at(index)
    @todos[index].undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.fetch(index)
    @todos.delete_at(index)
  end

  def to_s
    puts "---- Today's Todos ----"
    puts @todos
  end

  def each
    for i in todos
      yield(i)
    end

    self
    # Alternative: @todos.each { |todo| yield(todo) }
  end

  def select
    new_list = TodoList.new(title)

    each do |todo|
      new_list << todo if yield(todo)
    end

    # Alternative: using for loop
    # for i in @todos
    #   new_list << i if yield(i)
    # end

    # Alternative: without selected local variable
    #@todos.select { |todo| yield(todo) }

    new_list
  end

  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done
    select { |todo| todo.done? }.first
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  protected
  attr_accessor :todos
end


# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
p list.add(todo1)                 # adds todo1 to end of list, returns list
p list
p list.add(todo2)                 # adds todo2 to end of list, returns list
p list.add(todo3)                 # adds todo3 to end of list, returns list
#p list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add

# ---- Interrogating the list -----

# size
p list.size                       # returns 3

# first
p list.first                      # returns todo1, which is the first item in the list

# last
p list.last                       # returns todo3, which is the last item in the list

#to_a
p list.to_a                      # returns an array of all items in the list

#done?
p list.done?                     # returns true if all todos in the list are done, otherwise false

# ---- Retrieving an item in the list ----

# item_at
#list.item_at                    # raises ArgumentError
p list.item_at(1)                 # returns 2nd item in list (zero based index)
#list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
#list.mark_done_at               # raises ArgumentError
p list.mark_done_at(1)            # marks the 2nd item as done
p list.item_at(1)
#list.mark_done_at(100)          # raises IndexError

# mark_undone_at
#list.mark_undone_at             # raises ArgumentError
p list.mark_undone_at(1)          # marks the 2nd item as not done,
p list.item_at(1)
#list.mark_undone_at(100)        # raises IndexError

# done!
p list.done!                      # marks all items as done
p list.done?

# ---- Deleting from the list -----

# shift
p list.shift                      # removes and returns the first item in list

# pop
p list.pop                        # removes and returns the last item in list

p list

# remove_at
#list.remove_at                  # raises ArgumentError

#p list.remove_at(0)               # removes and returns the 2nd item
#list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

todo1.undone!
todo2.undone!
todo3.undone!

list.add(todo1)
list.add(todo2)
list.add(todo3)
#byebug
# to_s
list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym



todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

puts list.each { |todo| puts todo } # calls Todo#to_s

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# todo1.done!

# results = list.select { |todo| todo.done? }    # you need to implement this method

# puts results.inspect