# Assumptions

This is a non-exhaustive list of assumptions. My code contains some other implicit assumptions that I didn't include here to focus this document on the most important ones.

## General program
- I do not need to get user input
- Only `todo` instances have a strict set of properties: the other objects can have properties and methods that weren't suggested in the project description
- `todoList` is designed to work with a single collection of `todo` instances
- While `Todo` is used to create instances of `todo` objects, `todo`, `todoList` and `todoManager` don't create other objects
- Some edge cases aren't accounted for, such as:
  - `todo` instances have unique id values, but if you reassign them directly they can be set to any value

## `Todo` and `todo` instances
- `Todo` is used to create `todo` instances
  - User input isn't validated
  - Barring `id` and `completed`, user inputs will be coersed to type string
- By default, `todo` instances should initialize with a unique id and with `completed` assigned to `false`
  - Unique ids are set by a counter that's protected in the closure, which behaves like the surrogate key data type `serial` in PostgreSQL
- `todo` objects can have their properties reassigned
  - Nonetheless, the program protect `todo` objects through multiple layers of interfaces
- `todo` instances are added to `todoList` object

## `todoList`
- `todoList` is the interface with `todo` instances
  - `todoList` stores all `todo` instances in an array collection `todos`
  - `todoList` never returns the references of `todo` instances to protect their data integrity
    - I.e., when it returns a copy of the collection the `todo` objects will be shallow copies
- `getAllTodos()` method has the specific purpose of returning a shallow copy of the collection

## `todoManager`
- `todoManager` is the interface with `todoList` by passing `todoList` or an array of `todo` instances as arguments to its methods
  - Some methods interface with arrays of `todo` instances: `completedTodos()`, `isWithinMonthYear()`, `isCompletedAndWithinMonthYear()`
  - `allTodos()` interface with the `todoList` object
  - Explanation: expecting arrays of `todo` instances rather than a `todoList` object gives the methods more flexibility