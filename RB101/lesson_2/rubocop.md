# What is Rubocop?

Rubocop is a gem that helps us identify problems in Ruby. It's particularly helpful finding styling corrections.

Thus, it's a good idea to use it after we've finished a program to polish it.

## How does Rubocop work?

Rubocop has a set of rules that are set out in the `.rubocop.yaml` file.

There can be multiple `.rubocop.yaml` files. Rubocop starts searching for the file in the current and works upwards until it finds it.

Thus, we can modify Rubocop to specify what we want it to do across different directories.

## Creating `.rubocop.yaml` files

Create a new `.rubocop.yaml` file in the directory you want that to apply to.

Then, copy the contents in the file.

## Calling Rubocop

`rubocop <file_name.rb>`