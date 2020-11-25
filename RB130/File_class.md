# What is the File class?

`File` is an abstraction of any file object accessible by the program. It's closely associated with `IO`.

## Understanding `I/O`

`IO` is the abbreviation of input-output, and is the class that forms the basis for all input and output in Ruby.

I/O streams may be duplaxed or bidirectional (that is, input-output from different computers) — and thus may use multiple operating systems.

The only standard subclass of `IO` is `File`, which is closely associated.

# Instantiating a `File` object

The `File::new` method has the following characteristing:
```
new(filename, mode="r" [, opt]) → file
new(filename [, mode [, perm]] [, opt]) → file
```

Where `filename` is the path to find the file (found by executing the `pwd` command in the directory, and appending the file name).

```ruby
test = File.new("/Users/jadlp/repos/launch_school/RB130/File_class.md")
test  # #<File:0x00007f9e760cc148>
```

## Reading a `File` object

Continuing with the above code, `test.read` would return a string with the contents of the file — in this case, this markdown file.

We'd then be able to manipulate the string as any other.


# `File` and permissions

`File` methods operate in conjunction with permission bits, the platform specific set of bits that indicate the permissions of a file. In Unix-based systems they're a set of 2 octets — owner, group, and rest of the world, which can each be set as read, write, or execute the file.