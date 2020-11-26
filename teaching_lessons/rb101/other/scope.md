# What is a variable scope?

A variable is "in scope" if it can be referenced by the program at that given point.

Think of scopes in terms of vertical direction: you can go "up" (e.g. to the top level scope) or "down" into a leaky or self-contained scope

## Types of scope

- Leaky scope
  - You can access outside variables
  - The variables you create within that scope cannot be referenced at a higher scope
  - Created within blocks
- Self-contained scopes
  - You cannot access outside variables
  - The variables you create within that scope cannot be referenced at a higher scope
  - Created within methods
  - Caveat: the return value of the last executed line is returned by the method to the scope where the method was called