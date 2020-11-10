# Ruby installation on a Mac

Ruby is a part of the standard operating system (OS X/Mac OS) — this is called the **system Ruby**.

System Ruby is found in `/usr/bin/ruby`. It's usually an older version of Ruby.

```
$ /usr/bin/ruby -v
ruby 2.6.3p62 (2019-04-16 revision 67580) [universal.x86_64-darwin19]
$ ruby -v
ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-darwin19]
```

But the critical characteristic is that system Ruby **requires root access** to install and manipulate other Ruby components.

[This means that to use Ruby we'd need to act as a super user — at risk of making undesireable changes that could affect the version of Ruby used to manage our OS.]

<br>

## Implication: managing Ruby versions

Due to the above, we need to manage different versions of Ruby to program in MacOS.

Homebrew is a package manager designed for Macs. A **package manager** helps you install and manage tools, including but not limited to Ruby.

<br>

## Identifying Ruby versions

- How to find the version of Ruby: `$ ruby -v`
- How to find the *location* of Ruby: `$ which ruby`
  - System Ruby on Mac and Linux systems will be in `/usr/bin/ruby`
    - Note: in that same location system Ruby also stores other components like `irb` and `rake`
    - What is `/usr/bin/ruby`? It's an **aslias for the real directory that's nested deeply** in `/System/Library/Frameworks` (though this last directory shouldn't be used directly)
  - My current version is in `/Users/jadlp/.rbenv/shims/ruby`
    - Types of Ruby version managers
      - `rbenv`: the one I'm using
      - `rvm`

<br>

## What gets installed with Ruby?

- Core Ruby library
- Standard library
- `irb` REPL
- `rake` utility to automate Ruby development tasks
- `gem` command to manage RubyGems
- Documentation tools like `rdoc` and `ri`

<br>

# RubyGems

RubyGems are **packages of code that you can download, install, and run in Ruby programs or from the command line**.

`gem` command manages RubyGems.

Most used commands: [see RubyGems basics](http://guides.rubygems.org/rubygems-basics/) and common [use cases](https://guides.rubygems.org/rubygems-basics/).

## RubyGems, Ruby, and your computer

### Remote libraries

Gems are stored in remote libraries. The most commonly used is RubyGems Library, but it could also be a specialized remote library run by a school or an employer.

Once you've found a gem in a remote library you want to use, you can install it with `gem install GEM_NAME`.

### Local library

`gem` places the files of the installed RubyGem in your local file system. It places it in the local library — where Ruby and your system can find the files and commands it needs.

The location of the local library varies according to several factors:
- Are you using system Ruby and need root access?
- Specific Ruby version number
- Ruby version manager used

However, `gem` is able to install gems automatically.

### Finding a RubyGem in your local library

`$ gem env` returns information related to RubyGems installation.

```
$ gem env
RubyGems Environment:
  - RUBYGEMS VERSION: 3.1.2
  - RUBY VERSION: 2.7.1 (2020-03-31 patchlevel 83) [x86_64-darwin19]
  - INSTALLATION DIRECTORY: /Users/jadlp/.rbenv/versions/2.7.1/lib/ruby/gems/2.7.0
  - USER INSTALLATION DIRECTORY: /Users/jadlp/.gem/ruby/2.7.0
  - RUBY EXECUTABLE: /Users/jadlp/.rbenv/versions/2.7.1/bin/ruby
  - GIT EXECUTABLE: /usr/local/bin/git
  - EXECUTABLE DIRECTORY: /Users/jadlp/.rbenv/versions/2.7.1/bin
  - SPEC CACHE DIRECTORY: /Users/jadlp/.gem/specs
  - SYSTEM CONFIGURATION DIRECTORY: /Users/jadlp/.rbenv/versions/2.7.1/etc
  - RUBYGEMS PLATFORMS:
    - ruby
    - x86_64-darwin-19
  - GEM PATHS:
     - /Users/jadlp/.rbenv/versions/2.7.1/lib/ruby/gems/2.7.0
     - /Users/jadlp/.gem/ruby/2.7.0
  - GEM CONFIGURATION:
     - :update_sources => true
     - :verbose => true
     - :backtrace => false
     - :bulk_threshold => 1000
     - "gem" => "--no-document"
  - REMOTE SOURCES:
     - https://rubygems.org/
  - SHELL PATH:
     - /Users/jadlp/.rbenv/versions/2.7.1/bin
     - /usr/local/Cellar/rbenv/1.1.2/libexec
     - /Users/jadlp/.gem/ruby/2.7.0/bin
     - /Users/jadlp/.bin
     - /Users/jadlp/.rbenv/shims
     - /usr/local/sbin
     - /usr/local/bin
     - /usr/local/Cellar
     - /usr/local/bin
     - /usr/bin
     - /bin
     - /usr/sbin
     - /sbin
     - /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/
```

**Breaking down the information from `gem env`**
- RUBY VERSION: the version of Ruby associated with the `gem` command
  - Each version of Ruby has its own version of `gem` installed
  - WHy it's useful: it's a diagnostic — if you see the wrong number something's wrong
- RUBY EXECUTABLE: the location of the `ruby` command you should use with the Gems managed in this `gem` command
  - When it's useful: when there's a mismatch between `gem` and `ruby` => **What does this mean?**
- INSTALLATION DIRECTORY: where `gem` installs Gems by default
  - Caveat: varies according to the Ruby version being used
  - Visually, the installation directory with `rvm` looks like:
    ```
    $ tree /usr/local/rvm       # the following is partial output
    /usr/local/rvm
    ├── gems
    │   └── ruby-2.2.2          # This is the INSTALLATION DIRECTORY for all RubyGems
    │       ├── bin
    │       │   ├── bundle
    │       │   └── rubocop
    │       └── gems            # Local library with each gem-specific directory
    │           ├── bundler-1.12.5
    │           ├── freewill-1.0.0
    │           │   └── lib
    │           │       └── freewill.rb
    │           ├── pry-0.10.4  # /usr/local/rvm/gems/ruby-2.2.2/gems/pry-0.10.4
    │           └── rubocop-0.43.1
    └── rubies
        └── ruby-2.2.2
            └── bin
                ├── gem
                ├── irb
                └── ruby
    ```
- USER INSTALLATION DIRECTORY
  - Why it's needed: `gem` may install Gems somewhere in your home directory rather than in a system-level directory (e.g. in MacOS?)
  - Caveat: it has the same structure as the INSTALLARION DIRECTORY
- EXECUTABLE INSTALLATION DIRECTORY: commands that can be used directly from the terminal prompt
  - Note: still don't really get it, read more!
- REMOTE SOURCES: The remote library used by this `gem` installation
- SHELL PATH: the value of the shell's `PATH` variable which tells the shell where to find executable program files

## Finding the required file

Weird errors problems erise from using the wrong Gem in a program. For example, you might need a feature from the version 1.1.1 of a Gem call `freewill`, but when you run it you get an error saying the feature doesn't exist.

**So how can you find out the version of the Gem loaded by your program?**

You first need the full path name of the file (of the Gem) that your program loaded. Insert the following code or call in a debugger this shortly after requiring the Gem
```
puts $LOADED_FEATURES.grep(/freewill\.rb/)
```
Where `freewill` is the name of the RubyGem you're looking into to find its version number. The command looks within the `$LOADED_FEATURES` array and prints entries that match with the regexp.

It will return something like
```
/usr/local/rvm/gems/ruby-2.2.2/gems/freewill-1.0.0/lib/freewill.rb
```
Which tells you the Gem version (in this case, 1-0-0).

## Multiple Gem versions

If we install multiple versions of a Gem when we load a gem it'll use the most recent version.

For example, in the below file tree structure:
```
$ tree /usr/local/rvm      # the following is partial output
/usr/local/rvm
└── gems
    └── ruby-2.2.2        # This is the INSTALLATION DIRECTORY for Gems
        ├── bin
        │   ├── bundle
        │   └── rubocop
        └── gems
            ├── bundler-1.12.5
            ├── freewill-1.0.0
            │   └── lib
            │       └── freewill.rb
            ├── freewill-1.1.1
            │   └── lib
            │       └── freewill.rb
            ├── pry-0.10.4
            └── rubocop-0.43.1
```

We have two versions of `freewill`: `freewill-1.0.0` and `freewill-1.1.1` — both in `/user/local/rvm/gems/ruby-2.2.2/gems`.

This implies that when we include `freewill` `frewwill-1.1.1` will be loaded.

How can we load `freewill-1.0.0`?
- Using an absolute path name in `require` when you load the Gem
- Add `-I` to the Ruby invocation
- Modify `$LOAD_PATH` before requiring `SOME_GEM`
- Modifying the `RUBYLIB` environment variable

However: these are all quick fixes and will become hard to manage over time. The solution? Use bundler, covered later.

<br>

## Summary

- In MacOS the OS comes with a Ruby installation called system Ruby used to run the computer
  - However, it requires root access — which implies that mistakes can affect how your computer runs given the OS uses system Ruby – and usually operates on an old version
  - Thus, it's best to install a separate version of Ruby
- Ruby version managers install, run, and manage our versions of Ruby and their components, including RubyGems — the most popular being `rbenv` and `rvm`
- RubyGems are packets of code that can be installed and run in our programs
- RubyGems are stored online in remote libraries and locally in our local library
- `$ ruby -v` returns the version of Ruby while `$ which ruby` returns the location of where Ruby is stored locally

<br>

# Ruby Version Managers

Ruby version managers are programs to install, manage and use multiple versions of Ruby.

[**Note**: is a Ruby version manager a Ruby-specific package manager like Homebrew?]

We'd need this if we have programs that need to be run in specific Ruby version. Note that software applications tend to be run in a specific version of the — so if you're working on a project with of different version from your local Ruby you'll need to manage multiple versions.

Functionally, RVM and Rbenv do almost the same thing.

[**Note**: on MacOS use Rbenv because RVM has some problems on a Mac]

## How RVM works

The core of RVM is the `rvm` directory where it stores all the Ruby versions and Gems it manages. `rvm` has 2 subdirectories: `gems`, where it stores RubyGems, and `rubies`, where it stores the different versions of Ruby.

```
$ tree /usr/local/rvm        # the following is partial output
/usr/local/rvm               # RVM path directory
├── gems
└── rubies
```

Both `gems` and `rubies` are structured by the versions of Ruby installed. This helps Ruby find the appropriate files when it's using each version — that is, the standard Ruby executables in `rubies` and Gems in `gems`.
```
├── gems
│   ├── ruby-2.2.2
│   └── ruby-2.3.1
└── rubies
    ├── ruby-2.2.2
    └── ruby-2.3.1
```
Within each Ruby version subdirectory in `gems`, the version of the RubyGem being used can vary.
```
─── gems
    ├── ruby-2.2.2
    │   ├── bin
    │   └── gems
    │       └── rubocop-0.43.1
    └── ruby-2.3.1
        ├── bin
        └── gems
            └── rubocop-0.45.0
```

RVM defines a shell function named `rvm` to modify the environment.

When you use `rvm use VERSION` to change the Ruby version you want to use you're invoking the `rvm` shell function. This modifies the various ruby commands to invoke the correct Ruby version.

E.g., `rvm use 2.2.2` modifies the `PATH` variable so that the `ruby` command uses the Ruby versions installed in the `ruby-2.2.2` directory.

[**Note**: there are other changes, but this is the most noticeable]

```
# RVM file directories
├── gems
│   ├── ruby-2.2.2
│   │   ├── bin
│   │   └── gems
│   └── ruby-2.3.1
│   │   ├── bin
│   │   └── gems
└── rubies
    ├── ruby-2.2.2
    │   └── bin
    │       ├── gem
    │       ├── irb
    │       └── ruby
    └── ruby-2.3.1
    │   └── bin
    │       ├── gem
    │       ├── irb
    │       └── ruby
```

## Installing Rubies

You only need to install a version of Ruby once.

To check whether you have a Ruby version on RVM, run `$ rvm list rubies`:

```
$ rvm list rubies

rvm rubies

   ruby-2.1.5 [ x86_64 ]
=* ruby-2.3.1 [ x86_64 ]

# => - current
# =* - current && default
#  * - default
```

Let's assume we need version 2.2.2.

Since 2.3.1 is the current and default Ruby, and Ruby 2.2.2 doesn't appear, we need to install:

```
$ rvm install 2.2.2
```

## Setting/using local rubies

How do you tell RVM to use Ruby 2.2.2 once you've installed it?

The easiest way is to run:
```
$ rvm use 2.2.2
```
`rvm use` modifies your environment so that your system finds `2.2.2`. Besides `rvm`, this change in environment also affects `irb`, `gem`, and other related commands.

However, you won't usually do this in order to use the most up-to-date Ruby and apply older versions of Ruby on a specific directory-by-directory basis.

To define the default version of Ruby to be used by your system, run by Ruby by default in a new terminal session or shell, run:

```
$ rvm use 2.3.1 --default
```

This implies that if you later set a different Ruby in a directory you can return to using the default with:
```
$ rvm use default
```
Manually changing the versions of Ruby in your directory can get messy — **so how can we automate the changes**?

The easiest is to create a `.ruby-version` file in your project's root directory. The content of `.ruby-version` is the version number of ruby you want to use in that project. For example, if we want to use version 2.2.2 in the `~/src/magic` directory, we'd run:
```
$ cd ~/src/magic                # Go to the magic directory
$ rvm --ruby-version use 2.2.2  # Creates .ruby-version with Ruby 2.2.2
```

To be extra careful, you can also create a `.ruby-version` file in your root directory. This will work to make that Ruby version the default unless it's overriden in specific directories by another Ruby version in another `.ruby-version` file.

```
$ cd ~
$ rvm --ruby-version default
```

## Where Are My Rubies, Gems and Apps Now?

## When Things Go Wrong

## RVM Gemsets

<br>

# rbenv

## Installation paths for 2 different rubies

```
$ tree /usr/local/rbenv # the following is partial output
/usr/local/rbenv # rbenv root directory
├── shims
│   ├── bundle
│   ├── irb
│   ├── rubocop
│   └── ruby
└── versions
    ├── 2.2.2
    │   ├── bin
    │   │   ├── bundle
    │   │   ├── irb
    │   │   ├── rubocop
    │   │   └── ruby
    │   └── lib
    │       └── ruby
    │           └── gems
    │               └── 2.2.0
    │                   └── gems
    │                       ├── bundler-1.12.5
    │                       ├── freewill-1.0.0
    │                       │   └── lib
    │                       │       └── freewill.rb
    │                       ├── pry-0.10.4
    │                       └── rubocop-0.43.1
    └── 2.3.1
        ├── bin
        │   ├── bundle
        │   ├── irb
        │   ├── rubocop
        │   └── ruby
        └── lib
            └── ruby
                └── gems
                    └── 2.2.0
                        └── gems
                            ├── bundler-1.12.5
                            ├── freewill-1.0.0
                            │   └── lib
                            │       └── freewill.rb
                            ├── pry-0.10.4
                            └── rubocop-0.45.0
```

## How rbenv works

Similar to `RVM`, `rbenv` stores in a directory for each Ruby version the files associated with each. So `2.2.2` stores the files for the Ruby of that number and so forth. As with `RVM`, the versions of RubyGems can also vary by rubies — version 2.2.2 uses `rubocop-0.43.1` while version 2.3.1 uses `rubocop-0.45.0` in the examples above.

While the file structure is similar, `rbenv` works very differently from `RVM` under the hood.

`rbenv` uses a **set of small scrips called shims** that have the same names as the various ruby and Gem programs. They're typically stored in the `/usr/local/rbenv/shims` directory, within the `rbenv` directory.

We can find the rubies through:
```
$ rbenv versions
  system                                      # Mac OS system Ruby
  2.5.3
* 2.7.1 (set by /Users/jadlp/.rbenv/version)  # Default Ruby
```