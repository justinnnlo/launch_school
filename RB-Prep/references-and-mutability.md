# Variables and pointers

Objects are bits of data that are assigned a state or value. 

Variables allow us to do 2 key things related to objects:
1. Read code more easily by **tagging a value with a descriptor** (the variable name)
2. More easily reference a value (through its descriptive name rather than the exact value)

Variables are like name tags: you write a name and paste it on an object. When you want to change the object of a tag, you just take the tag out and place it somewhere else.

# Variable reassignment

Variables are not the object themselves, they only point to where the object is. We can stress-test this mechanism by seeing what happens when variables point to other variables.

~~~
a = 7 # a references or is bound to 7
b = a # `b` points to 7 because `b` points to `a` which points to 7
a += 2 # a has been reassigned to point to 9
b # b still points to 7 because the location of 7 was never changed
~~~

# Object mutation

Yet when 2 variables point to the same object and the object is mutated, both variables now output a new value.

~~~
a = "hello" # a references or is bound to "hello"
b = a # `b` points to 7 because `b` points to `a` which points to 7
a.upcase! # a has been reassigned to point to 9
b # b returns "HELLO" because the underlying object it points to has changed
~~~

Similarly:
~~~
a = [1, 2, 3] # a references or is bound to "hello"
b = a # `b` points to 7 because `b` points to `a` which points to 7
a.pop # The array loses its last element as pop is a destructive method
b # b [1, 2] because the underlying object it points to has changed
~~~

# Variables across languages

