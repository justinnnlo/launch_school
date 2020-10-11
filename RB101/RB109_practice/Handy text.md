On `line X` we **initialize** the variable `Y` and bind it to `Z`

On line `X` we are **calling on `[OBJECT]` the `#[METHOD]**` method 

​	and **passing a `do...end` block** with `[# PARAMETERS]` parameter  `[PARAMETERS]`, creating a new leaky scope.

On line `X` we are calling on `[OBJECT]` the `#[METHOD]` method 

​	and **passing a `{ }` block** with `[# PARAMETERS]` parameter  `[PARAMETERS]`, creating a new leaky scope

The `select` method considers if the return value of the block evaluates to `true` or not

On line 4 we are calling the `#times` method on the integer `2` and passing a `do...end` block with a parameter `a`

On line 5 we are reassigning the block parameter `a` to the value 5 each time the block is executed

On line 6 we are printing to the output the block parameter `a` (with value 5) and returning `nil`.