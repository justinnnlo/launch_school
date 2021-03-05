- What happens to an object passed to a method?
  - Ruby passes an object id to a method
  - If the object was passed via a variable, the variable still points to the same object as it's outside the method's scope
  - It then stores the ID in a local variable
  - If the method mutates the object or the elements contained in it, it will be reflacted outside the method
    - Passing `[1, 2, 3]` and reassigning the first value (1) to 10: does not mutate the object but changes its contents `[10, 2, 3]`
    - Passing `{ "age" => 48}` and reassiging 48 to "hello": does not mutate the object but changes its contents `{ "age" => "hello"}`

- Key concept: object mutation is changing the state of an object. It is **not simply changing its object id**. A hash or array that changes its elements mutates even though its object ID remains the same.