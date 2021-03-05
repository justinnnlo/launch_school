# `Todo` and `todo` instances

- `Todo` is an object that will be used as a prototype of multiple `todo`s
- Input validation: none, but all inputs will be coersed to strings as all property value inputs need to be strings
  - Excludes `id` and `completed` values (number and boolean respectively)
- Has a `counter` property that keeps track of unique ids and allows us to make sure they're unique
- Has `isWithinMonthYear(month, year)` method
- Has `init` method
- All properties are directly accessible
  - Implication: id may not be unique if mutated

## Areas of improvement
- `id` can be reassigned — which can compromise the requirement of having all ids be unique
  - However, `todoList` manipulates `todo`s — so they're protected
- Creating default values for `title` if it has an invalid (`undefined`, `null`, other non-string) or empty string input


# `todoList`
- Create an object that can be used as the `todoList``
  - Ie., not meant to be used my multiple lists


## Assumptions
- Needs an additional `getAllTodos` method to return a copy of all todos
- `update` cannot modify the `id` property
- `update` assumes inputs will be appropriate and doesn't do input validation

# Project guidelines

- Objective: build the logic of a todo application

- Structure
  - `Todo` creates `todo` objects
  - `todoList` is an object that collects `todo` objects
  - `todoManager` returns a set of todos from a `todoList` based on a criteria

- Objects to create
  - `Todo`: creates `todo` objects
  - `todo` objects
  - `todoList`: object that collects multiple `todo`s
  - `todoManager`: ??? 

- Deep dive per object
  - `todo` objects should have
    - Properties
      - Created automatically
        - ID (unique): automatically generated
          - Could be using something like SQL `serial`: use a counter that keeps track of the number of `todo` objects and when one's created increase by 1
        - Completed (boolean): defaults to `false`
      - Created via inputs
        - Title (string)
        - Month (string)
        - Year (string)
        - Description (string)
    - Methods (across all `todo` objects)
      - `isWithinMonthYear` (see below)

  - `Todo`
    - `init` to initialize each `todo`
    - `isWithinMonthYear`: shared to `todo` objects as `Todo` will be their prototype
      - Input: month and year (both strings)
      - Output: boolean based on whether the `todo` object has that month AND year

  - `todoList`
    - Properties
      - `list`: array collection of `todo` objects
        - Should be protected or placed as a publicly accessible property?
    - Methods
      - `add()`: adds a `todo` to the list — OK
        - Input: `todo` object
        - Output:
          - Return shallow copy of all todos
      - `delete()`: deletes a `todo` from the list — OK
        - Input: string id of a `todo` object
          - Needs input validation to check if the id exists
        - Output:
          - If the id exists in the list, splice and remove that object
          - Return shallow copy of all todos
      - `init` — OK
        - Input: array of `todo`s
        - Behavior: assign array to the `list` property
        - Output: `todoList` object
      - `update()` — OK
        - Input: id of `todo` and an object
        - Behavior: if the id exists in the list **and** the property key is found in the object, reassign the `todo`'s value to the object's value of that property
        - Output:
          - If `id` exists: `true`
          - Else: `false`
      - `fetchTodo()` — OK
        - Input: id of `todo`s
        - Behavior: filter and return only the `todo` with that id
        - Output:
          - Copy of desired object if it exists
          - Else, return false

  - `todoManager`: interacts with the `todoList`
    - `allTodos()`
      - Input: `todoList` object
      - Output: return an array with all `todo`s
    - `completedTodos()`
      - Input: `todoList` object
      - Output: return an array with all `todo`s whose property `completed` is `true`
    - `isWithinMonthYear()`
      - Input: `todoList` object, and month and year strings
      - Returns an array with all `todo`s whose property `month` and `year` is the same as the inputs
    - `isCompletedAndWithinMonthYear()`
      - Input: `todoList` object, and month and year strings
      - Returns an array with all **completed** `todo`s whose property `month` and `year` is the same as the inputs

# Questions
- The array used to track `todo`s in `todoList` **is/isn't** publicly accessible
- Can empty `todo` data be accepted?
  - Should there be defaults?
    - Month and year: current month and year
      - What about cases where one is entered but not the other? E.g. month = '1', year = ''
    - Title
      - Default to 'My todo' or something similar, or force an input?
    - Description: allow none
- `isWithinMonthYear`
  - Need to validate both month and year?
  - Only that they're numbers?