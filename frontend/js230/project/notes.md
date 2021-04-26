# Project PEDAC

## Problem

Create a todo-list app.

The 2 main components are:

- The `main` areat that contains the todo list
- The `nav` area that groups todo list items by date and completion status

There is also a secondary `modal` component that will also need to be used.

### `main` requirements

- ~~Clicking on the "Add new todo" label right above the checkboxes shows the modal~~
- The title represents the todo group selected — and displays the todos of that group
- ~~Todo items, when hovered, will have a light blue background~~
- ~~When the todo list item **text** is hovered it will also turn light-blueish~~
- ~~Clicking on the `td` element where the todo list item text is in will toggle the todo (completed/incomplete)~~
  - When a todo list item is completed it should
    - Be placed in the bottom
    - ~~Have its box checked~~
    - ~~Turn its box and text gray, with the text crossed-out~~
    - Not change the todo list count
- ~~Clicking on the todo list item **text** will open the modal with that item's details~~
- ~~Clicking on the todo list item's **trashcan or its surrounding area** will delete the todo in the server and browser, and update the view~~
- Toggling a todo should not change the currently selected group
- ~~The name of each todo item will be: `name - Due Date`~~
  - `Due Date` will display `mm/yy` unless either the month or year is missing
    - In those cases, display `No Due Date`

### `nav` requirements

- The `nav` displays all groups within 2 major list areas:
  - All todos
    - Within it it's organized by due dates: `No Due Date` and `mm/yy` collections
  - Completed todos
    - Within it it's organized by due dates: `No Due Date` and `mm/yy` collections
- Clicking on a todo group selects those items and displays them in the `main`
- Each group has a count displayed to its right

### `modal` requirements

- ~~The modal is shown when a todo item is selected or you're in the process of creating a new todo item~~
  - When editing an item, it shows that item's details in the input fields
- Clicking "Save" closes the modal
  - Names have to be at least 3 characters long (raise alert otherwise)
  - When the modal is hidden
    - If you were creating a new todo: always display all todos
    - If you were editing/viewing an existing todo: display the group that was selected before you clicked on it
- Clicking "Mark as Complete"
  - Adding a new item: raises an alert that it cannot be done
  - Editing an existing item: marks it as completed and hides the modal (following the pattern of edited todos)
- Clicking outside rhe modal closes it

## General requirements

- CRUD opes should **first happen on the server** and then on the front end
  - Don't update the DOM before the server request has received a **successful** response
- Submit as a ZIP file the `public` folder and its contents only, with a README.md if it exists
  - Exclude `node_modules` directory


# Plan

1. Todo list (`main` panel) with the modal

- ~~You can click on "+ Add new to do" to bring up the modal to create a new todo~~
- ~~You can delete a todo (we'll do "mark as complete" later) using the trash can icon.~~
- ~~The number after on the top of the right panel should reflect the total number of todos.~~

2. Due dates and completion

- ~~After a todo is created, you can click on it which will bring up a modal that shows details of the todo. Here you can add a due date for the todo after you click on "save," it should close the modal, save the todo and reflect any changes in the DOM. For example, if the todo's name is "buy some milk" and it's due on 08/20/2016, show it as "buy some milk - 08/16".~~
- ~~In the details modal of a todo, have a button to mark this todo as complete. Once clicked, this should close the modal, and show the todo as completed with a strike-through.~~
- All completed tasks should be at the bottom of the todo list.

3. Todolist by months

- Now we're going to have a list of months for due dates of todos on the left navigation
- the due months, in the format of (mm/yy), should be dynamic and based on the due dates of all the todos.
- the numbers after the "All Todos," "Completed" and the due months are dynamic and they should be the number of todos that due in that month.
- by default, all todos are created in the "No Due Date" list, but when a Todo has a due date, it should be put into the month that it's due.
- when a todo is completed, it should be put into the "Completed" lists.
- when you click on a group (todos due for a specific month), refresh the main area with only the todos from that group

# Handlebars components

- `main_template`
  - `all_todos`: div to contain the `all_todos_template` component
    - This is a partial with all todo items
  - `all_lists`: article to contain `all_list_template`
  - `completed_todos`: div to contain `completed_todos_template`
  - `completed_lists`: article to contain `completed_list_template`
  - `items`: div to contain
    - within its header: `title_template`
    - Within `main`: `list_template` and the modal
- `item_partial`: contains a table to display the item, the item's status, and the delete button with
  - Item's `id`
  - Checked or unchecked box
- 



# Problem: sort the array of objects by date

Input: array of objects
Output: object with dates as key and values as objects

What's killing it: I can't compare dates with strings
- Remove "No Due Date" and place it first in the object
  - Remove from: the keys array