# Setting up a project directory

The first thing when starting a Ruby project is to set up the working directory. A project is a collection of one or more files to:

- Develop
- Test
- Build
- Distribute

software.

The software can be anything: an executable program, library module, or combination of program and library files. It may include:

- Different languages (e.g. Ruby and Javascript)
- Test assets
- Databases
- HTML and CSS files
- Configuration files
- And more

## Directory names

The name of the directory should be restricted to:
- Letters
- Digits
- Underscores

because some tools have trouble with directory names. **Avoid spaces in directory names** — weird bugs can arise.

## Project standarization

To help developers move from one project or another, most Ruby projects have a standard pattern that includes:
- Certain files and directories
- Types of data stored in certain locations
- Some data presented in a predefined format
- Etc

## Project directory organization

- Test code should be in the `test` directory
- Ruby source files should be in the `lib` directory
- Assets (images, Javascript, CSS) reside in `assets` with a subdirectory for each type
  - `images`
  - `javascript`
  - `stylesheets`
- HTML files are typically stored in `views`

# Setting up the Gemfile

Configure Bundler after setting up the project directory.

Bundler uses a file named `Gemfile` to determine a proejct's dependencies. This will let other devs know how to run your project.

A `Gemfile` typically needs information about:
- Where should Bundler look for RubyGems it needs to install?
  - Typically: the official RubyGems site at https://rubygems.org
  - E.g. `source "https://rubygems.org"`
- Do you need a `.gemspec` file?
  - Needed when `Gemfile` has a `gemspec` statement
- What version of Ruby does the program need?
  - Ideally use newer versions, but some users may need to use an older one.
    - It's a good idea to specify a Ruby version — otherwise bundler will use a different one if your default changes in the future
    - `rbenv local [VERSION]` tells Rbenv to use said version locally in that directory and its subdirectories
  - E.g. `ruby "2.5.0"`
- What RubyGems does the program use?
  - Check the `require` statements in your program and add those gems to `Gemfile`, e.g.
    - `minitest`, `minitest-reporters`
      - `gem "minitest", '~> 5.10'`
      - `gem "minitest-reporters", '~> 1.1'`
        - Note: `~> 5.10` means "use version 5.10 or above but prior to version 6.0" — this helps avoid compatibility issues
  - Note: after you add new gems you need to run `bundle install` again

Once Gemfile is complete, tell Bundler to find and install the project's depencencies with `bundle install`. Its output looks like:
```
$ bundle install
Fetching gem metadata from https://rubygems.org/..................
Resolving dependencies...
Using ansi 1.5.0
Using builder 3.2.4
Using bundler 2.1.4
Fetching minitest 5.14.0
Installing minitest 5.14.0
Using ruby-progressbar 1.10.1
Using minitest-reporters 1.4.2
Bundle complete! 2 Gemfile dependencies, 6 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

`bundle install` also creates a `Gemfile.lock` file that contains all of the information about the dependencies used by the app. Every time you update `Gemfile` you should run `bundle install` so that the app uses the correct files and versions.

As a final step, in all of the main Ruby program files add `require bundler/setup` **before any other `require` statement to load the dependencies. Note that **`bundler/setup` prevents Ruby from finding any Gem that isn't in `Gemfile`.

# Rake

Rake is a Rubygem that automates common functions required to build, test, package and install programs. It comes with modern Ruby installations — you don't need to install it.

Common Rake tasks include:
- Set up required environments by creating directories and files
- Set up and initialize databases
- Run tests
- Package your application and all of its files for distribution
- Install the application
- Perform common Git tasks
- Rebuild certain assets based on changes to other files and directories

## Using Rake

Rake uses a file names `Rakefile` that lives in the project directory. This file describes the tasks that Rake can perform for your project and how to perform them.

A simple Rake file is:

```ruby
desc 'Say hello'
task :hello do
  puts "Hello there. This is the `hello` task."
end

desc 'Say goodbye'
task :bye do
  puts 'Bye now!'
end

desc 'Do everything'
task :default => [:hello, :bye]
```

Note that `Rakefile` is written in Ruby code, alongside a DSL supplied by Rake.

This `Rakefile` consists of 3 tasks: `:hello` and `:bye` display a message, and `:default` has both `:hello` and `:bye` as dependencies. Rake runs the `:default` task unless you provide a specific task name when you invoke Rake.

Each of the 3 tasks call 2 Rake methods: `desc` and `task`.
- `desc` provides a short description of the task when you run `rake -T`
- `task` associates a name with either
  1. a block of code or (114-116; 119-121)
  2. a list of dependencies (124)
    - Note: when running `:default` rake will first execute both `:hello` and `:bye` dependencies because it depends on them

### What tasks can a Rake file execute?

We can find this out by running `bundle exec rake -T`, which outputs each command with its description — alphabetically ordered by its `task` name
```
$ bundle exec rake -T
rake bye      # Say goodbye
rake default  # Do everything
rake hello    # Say hello
```

The above result shows that there are 3 defined tasks in `Rakefile`: `bye`, `default` and `hello`, and their descriptions come from `desc` above.

[Note: though `rake -T` usually works, running `bundle exec rake - T` when you use bundler to ensure that you use the current version of `rake` when you execute the command. `rake` is not a component of Bundler — we're just using Bundler to ensure we're running the Bundler environment with any code run from `Rakefile`]

## Running tests

A common Rake task is to run tests associated with the project to make sure everything is working as it should after changing some code. In the case of the Todo List project, this would look like
```ruby
desc "Run tests"
task :test do
  sh "ruby ./test/todolist_project_test.rb" # sh is a rake method that writes to shell
end
```
Where the rake command is run from the project directory of Todo List.

## Standard tasks

The limitation with the code above is that we're manually telling `Rakefile` what files to run to do the testing. If we were to add new files, we'd also have to manually update it.

We can automate this via `rake/testtask` — which can build the list of tests.

The updated `Rakefile` would look like
```ruby
require "rake/testtask"

desc "Say hello"
task :hello do
  puts "Hello there. This is the 'hello' task."
end

desc "Run tests"
task :default => test

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb]
end
```

The code in the `Rake::TestTask.new` block tells `rake/testtask` that the tests and source code reside in the `test` and `lib` directories. It also tells it that the test files reside in `test` and have a name that ends with `_test.rb`.

## Creating default tasks

We can set-up tasks as default tasks if we run them often. When you run rake with no parameters it'll execute these tasks.

# Preparing a RubyGem

Most Ruby projects are distributed through RubyGems. They require following certai npractices when building a project — among them a `.gemspec` file and a common directory structure.

The directory structure is the one covered above:
- Project directory with
  - `lib` to put the source code
  - `test` to put the tests
  - `README.md` file
  - `[PROJECT].gemspec` file
  - `Gemfile` and `Rakefile` (if applicable)

## `.gemspec`

A sample `.gemspec` file includes:
```ruby
# todolist_project.gemspec
Gem::Specification.new do |s|
  s.name        = 'todolist_project'
  s.version     = '1.0.0'
  s.summary     = 'Todo List Manager!'
  s.description = 'This is a simple todo list manager!'
  s.authors     = ['Pete Williams']
  s.email       = 'pw@example.com'
  s.homepage    = 'http://example.com/todolist_project'
  s.files       = ['lib/todolist_project.rb', 'test/todolist_project_test.rb']
end
```

## Rakefile modifications

If the project has a `Rakefile`, we need to add at the top
```ruby
require "bundler/gem_tasks"
```

`bundler/gem_tasks` adds several tasks to the Rakefile that are common to Rubygems like:
- `rake build`: constructs a `.gem` file in the `pkg` directory that contains the actual Rubygem that you will distribute
- `rake install`: runs `rake build` and then installs the program in your Ruby's Gem directory — allowing you to test the gem without loading information from your project directory
- `rake release`: send your `.gem` file to the remote Rubygems library for anyone to download