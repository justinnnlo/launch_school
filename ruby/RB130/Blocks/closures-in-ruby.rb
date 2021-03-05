# CLOSURES IN RUBY     Paul Cantrell    https://innig.net
# Email: username "paul", domain name "innig.net"

# I recommend executing this file, then reading it alongside its output.
#
# Alteratively, you can give yourself an unreasonable Ruby test by deleting all
# the comments, then trying to guess the output of the code!
#
# (Naive HR departments, please do not use that idea as a hiring quiz.)

# A closure is a chunk of code which meets three criteria:
# 
#     * It can be passed around as a value and
# 
#     * executed on demand by anyone who has that value, at which time
# 
#     * it can refer to variables from the context in which it was created
#       (i.e. it is closed with respect to variable access, in the
#       mathematical sense of the word "closed").
#
# (The word "closure" actually has an imprecise meaning, and some people don't
# think that criterion #1 is part of the definition. I think it is.)
# 
# Closures are a mainstay of functional languages, but are present in many other
# languages as well. Scheme pioneered them; more recently Javascript, popularized
# them. They enable all sort of cool stuff: they allow deferred execution and some
# elegant tricks of style.
# 
# Ruby is based on the "principle of least surprise," but I had a really nasty
# surprise in my learning process. When I understood what methods like "each"
# were doing, I thought, "Aha! Ruby has closures!" But then I found out that a
# function can't accept multiple blocks -- violating the principle that closures
# can be passed around freely as values.
# 
# This document details what I learned in my quest to figure out what the deal is.

system("clear") || system("cls")

def example(num)
  puts
  puts "------ Example #{num} ------"
end

# ---------------------------- Section 1: Blocks ----------------------------

# Blocks are like closures, because they can refer to variables from their defining context:

example 1

def thrice
  yield
  yield
  yield
end

x = 5
puts "value of x before: #{x}"
thrice { x += 1 }
puts "value of x after: #{x}"

# A block refers to variables in the context it was defined, not the context in which it is called:

example 2

def thrice_with_local_x
  x = 100
  yield
  yield
  yield
  puts "value of x at end of thrice_with_local_x: #{x}"
end

x = 5
thrice_with_local_x { x += 1 }
puts "value of outer x after: #{x}"

# A block only refers to *existing* variables in the outer context; if they don't exist in the outer,
# a block won't create them there:

example 3

thrice do  # note that {...} and do...end are completely equivalent
  y = 10
  puts "Is y defined inside the block where it is first set?"
  puts "Yes." if defined? y
end
puts "Is y defined in the outer context after being set in the block?"
puts "No!" unless defined? y

# OK, so blocks seem to be like closures: they are closed with respect to variables defined in the
# context where they were created, regardless of the context in which they're called.
# 
# But they don't look quite like closures in the code above because we aren't passing them around
# as we would any othe value: "yield" can *only* refer to the block passed to the method it's in.
#
# We can pass a block on down the chain, however, using &:

example 4

def six_times(&block)
  thrice(&block)
  thrice(&block)
end

x = 4
six_times { x += 10 }
puts "value of x after: #{x}"

# So do we have closures? Not quite! We can't hold on to a &block and call it later at an arbitrary
# time; it doesn't work. This, for example, will not compile:
#
# def save_block_for_later(&block)
#     saved = &block
# end
#
# But we *can* pass it around if we use drop the &, and use block.call(...) instead of yield:

example 5

def save_for_later(&b)
  @saved = b  # Note: no ampersand! This turns a block into a closure of sorts.
end

save_for_later { puts "Hello!" }
puts "Deferred execution of a block:"
@saved.call
@saved.call

# But wait! We can't pass multiple blocks to a function! As it turns out, there can be only zero
# or one &block_params to a function, and the &param *must* be the last in the list.
#
# None of these will compile:
#
#    def f(&block1, &block2) ...
#    def f(&block1, arg_after_block) ...
#    f { puts "block1" } { puts "block2" }
#
# What the heck?
#
# I claim this single-block limitation violates the "principle of least surprise." The reasons for
# it have to do with ease of C implementation, not semantics.
#
# So: are we doomed, never to do anything wild and Lisp-like with closures?

 
# ---------------------------- Section 2: Closure-Like Ruby Constructs ----------------------------

# Despair not! When we pass a block &param, then refer to that param without the ampersand, that
# is secretly a synonym for Proc.new(&param):

example 6

def save_for_later(&b)
  @saved = Proc.new(&b)  # same as: @saved = b
end

save_for_later { puts "Hello again!" }
puts "Deferred execution of a Proc works just the same with Proc.new:"
@saved.call

# We can define a Proc on the spot, no need for the &param:

example 7

@saved_proc_new = Proc.new { puts "I'm declared on the spot with Proc.new." }
puts "Deferred execution of a Proc works just the same with ad-hoc Proc.new:"
@saved_proc_new.call

# Behold! A true closure!
#
# But wait, there's more.... Ruby has a whole bunch of things that seem to behave like closures,
# and can be called with .call:

example 8

@saved_proc_new = Proc.new { puts "I'm declared with Proc.new." }
@saved_proc = `proc { puts "I'm declared with proc." }`
@saved_lambda = lambda { puts "I'm declared with lambda." }
def some_method 
  puts "I'm declared as a method."
end
@method_as_closure = method(:some_method)

puts "Here are four superficially identical forms of deferred execution:"
@saved_proc_new.call
@saved_proc.call
@saved_lambda.call
@method_as_closure.call

# So in fact, Ruby has no less than seven -- count 'em, SEVEN -- different closure-like constructs:
#
#      1. block (implicitly passed, called with yield)
#      2. block (&b  =>  f(&b)  =>  yield)  
#      3. block (&b  =>  b.call)    
#      4. Proc.new  
#      5. proc  
#      6. lambda    
#      7. method
#
# Though they all look different, some of these are secretly identical, as we'll see shortly.
#
# We already know that (1) and (2) are not really closures -- and they are, in fact, exactly the
# same thing. Numbers 3-7 seem identical. Are all 7 just different syntaxes for identical semantics?


# ---------------------------- Section 3: Closures and Control Flow ----------------------------

# No, they aren't! One of the distinguishing features has to do with what "return" does.
#
# Consider first this example of several different closure-like things *without* a return statement.
# They all behave identically:

example 9

def f(closure)
  puts
  puts "About to call closure"
  result = closure.call
  puts "Closure returned: #{result}"
  "Value from f"
end

puts "f returned: " + f(Proc.new { "Value from Proc.new" })
puts "f returned: " + f(proc { "Value from proc" })
puts "f returned: " + f(lambda { "Value from lambda" })
def another_method
  "Value from method"
end
puts "f returned: " + f(method(:another_method))

# But put a "return" inside a proc, and surprising things happen!

example 10

def g
  f(proc { return "Value from proc" })
  puts "Finished with g!"
end

g

# Wait, what? A little more logging will make it clear:

example 11

def g
  result = f(proc { return "Value from proc" })
  puts "f returned: " + result  # never executed
  "Value from g"                # never executed
end

puts "g returned: #{g}"

# Note that the return inside the proc didn't just return from the proc -- it returned
# all the way out of g, bypassing not only the rest of g but the rest of f as well! It worked
# almost like an exception.
#
# This means that it's not possible to call a proc containing a "return" when the creating
# context no longer exists:

example 12

def make_proc_new
  begin
    Proc.new { return "Value from Proc.new" } # this "return" will return from make_proc_new
  ensure
    puts "make_proc_new exited"
  end
end

begin
  puts make_proc_new.call
rescue Exception => e
  puts "Failed with #{e.class}: #{e}"
end

# (Note that this makes it unsafe to pass Procs across threads.)

# A proc, then, is not quite truly closed: it depends on the context where it was created still
# existing, because the "return" is tied to that context.
#
# Not so for lambda:

example 13

def g
  result = f(lambda { return "Value from lambda" })
  puts "f returned: " + result
  "Value from g"
end

puts "g returned: #{g}"

# And yes, you can call a lambda even when the creating context is gone:

example 14

def make_lambda
  begin
    lambda { return "Value from lambda" }
  ensure
    puts "make_lambda exited"
  end
end

puts make_lambda.call

# Inside a lambda, a return statement only returns from the lambda, and flow continues normally.
# So a lambda is like a function unto itself, whereas a Proc remains dependent on the control
# flow of its caller.
#
# A lambda is Ruby's true closure.

# Note that "proc" is in fact just a shortcut for "Proc.new". Amusingly, or horrifyingly, this
# was not always the case! In Ruby 1.8, "proc" was a synonym for ... "lambda".
#
# Let's all raise a glass to compatibility-breaking language changes.

# I'll spare you the rest of the experiments, and give you the behavior of all 7 cases:
#
# "return" returns from caller:
#      1. block (called with yield)
#      2. block (&b  =>  f(&b)  =>  yield)  
#      3. block (&b  =>  b.call)    
#      4. Proc.new
#      5. proc
#
# "return" only returns from closure:
#      6. lambda    
#      7. method


# ---------------------------- Section 3a: But...WHY? ----------------------------

# Why on earth would we want a thing with this strange behavior? Because it makes Ruby’s loops
# beautiful. Javascript developers using closure-based forEach constructs will be familiar with the
# conundrum that Ruby’s blocks solve.
#
# Suppose we want to write a Javascript function that efficiently checks whether the running sum of
# numbers in an array ever exceeds some maximum:
#
#   function isSumGreaterThan(array, max) {
#     let sum = 0;
#     for(let x of array) {
#       sum += x;
#       if(sum > max) {
#         return true;  // Stop searching! We have our answer.
#       }
#     }
#     return false;
#   }
#
# If we try to write this code with forEach(), which closely resembles Ruby’s each(),
# the same approach suddenly breaks:
#  
#   function isSumGreaterThan(array, max) {
#     let sum = 0;
#     array.forEach((x) => {
#       sum += x;
#       if(sum > max) {
#         return true;  // Oops! Doesn't work
#       }
#     });
#     return false;
#   }
#
# The problem is that "return true" doesn’t return from isSumGreaterThan(); it only returns from the
# closure we’re passing to forEach. To make that work using functional iteration in Javascript -- or
# in most true functional languages, for that matter! -- we have to switch from forEach to an
# entirely different method of Array:
#
#   function isSumGreaterThan(array, max) {
#     let sum = 0;
#     return array.some((x) => {
#       sum += x;
#       return sum > max;
#     });
#   }
#
# But Ruby doesn’t need a special case, because Ruby’s blocks and procs retain the control flow of
# their context. Unlike Javascript, a return inside a loop is the same as a return outside one:

example 15

def is_sum_greater_than(array, max)
  sum = 0
  array.each do |x|
    sum += x
    return true if sum > max  # returns from is_sum_greater_than, not just the block
  end
  return false
end

puts is_sum_greater_than([5, 3, 7], 10)
puts is_sum_greater_than([5, 3, 7], 20)

# Control flow constructs like "next" and "break" have the same behavior.
#
# THIS is why Ruby has the two superficially similar but fundamentally different constructs of
# blocks and lambdas. It is a defining feature of the language: blocks and closures, two different
# forms of code-as-value, existing side by side.

# (Interestingly, Swift makes a very similar distinction with between @escaping and non-espcaing
# closures; however, it does not adopt Ruby’s dual control flow behavior.)


# ---------------------------- Section 4: Closures and Arity ----------------------------

# The other major distinguishing of different kinds of Ruby closures is how they handle mismatched
# arity -- in other words, the wrong number of arguments.
#
# In addition to "call," every closure has an "arity" method which returns the number of expected
# arguments:

example 16

puts "One-arg lambda:"
puts (lambda {|x|}.arity)
puts "Three-arg lambda:"
puts (lambda {|x,y,z|}.arity)
puts "No-args lambda: "
puts (lambda {}.arity)

# ...with a special case:

puts "Varargs lambda: "
puts (lambda {|*args|}.arity)

# Watch what happens when we call these with the wrong number of arguments:

example 17

def call_with_too_many_args(closure)
  begin
    puts "closure arity: #{closure.arity}"
    closure.call(1,2,3,4,5,6)
    puts "Too many args worked"
  rescue Exception => e
    puts "Too many args threw exception #{e.class}: #{e}"
  end
end

def two_arg_method(x,y)
end

puts; puts "proc:"    ; call_with_too_many_args(proc {|x,y|})
puts; puts "lambda:"  ; call_with_too_many_args(lambda {|x,y|})
puts; puts "Method:"  ; call_with_too_many_args(method(:two_arg_method))

def call_with_too_few_args(closure)
  begin
    puts "closure arity: #{closure.arity}"
    closure.call()
    puts "Too few args worked"
  rescue Exception => e
    puts "Too few args threw exception #{e.class}: #{e}"
  end
end

puts; puts "proc:"    ; call_with_too_few_args(proc {|x,y|})
puts; puts "lambda:"  ; call_with_too_few_args(lambda {|x,y|})
puts; puts "Method:"  ; call_with_too_few_args(method(:two_arg_method))

 
# ---------------------------- Section 5: Rant ----------------------------
#
# This is quite a dizzing array of syntactic options, with subtle semantics differences that are not
# at all obvious, and riddled with minor special cases. It's like a big bear trap from programmers
# who expect the language to just work.
#
# Complex as it is now, the behavior above used to be far more complex, with special cases that were
# utterly nonsensical.
#
# Why are things this way? Because Ruby is:
#
#   (1) designed by implementation, and
#   (2) defined by implementation.
#
# The language grows because the Ruby team tacks on cool ideas, without maintaining a real spec
# apart from CRuby. A spec would make clear the logical structure of the language, and thus help
# highlight inconsistencies like the ones we've just seen. Instead, little inconsinstencies creep
# into the language, confuse the crap out of poor souls like me who are trying to learn it, and then
# get submitted as bug reports. Yes, I know, language design is hard -- but something like this
# proc/lambda issue or the arity problem wasn't so hard to get right the first time. Yammer yammer.

# ---------------------------- Section 5a: Counter-Rant ----------------------------
#
# When I first wrote this guide in ~2006, the rant above was much more justified because there
# were all sorts of goofy inconsistencies in the arity behavior and Kernel.proc made lambdas and
# not procs. The whole thing had a sort of "is anybody paying attention?!" feeling.
#
# Well, yes, anybody was. Subsequent releases of the language mopped up the arity inconsistencies,
# and made "proc" mean proc. Ruby still doesn't have a specification -- but it does have an active
# community and a willingness to correct its mistakes, and it turns out that's even better.
#
# A spec would still be nice though.
 

# ---------------------------- Section 6: Summary ----------------------------
#
# So, what's the final verdict on those 7 closure-like entities?          
#
#                                                  "return" returns from closure
#                                 True closure?    or declaring context...?       Arity check?
#                                 ---------------  -----------------------------  ------------
# 1. block (called with yield)    N                declaring                      no
# 2. block (&b => f(&b) => yield) N                declaring                      no
# 3. block (&b => b.call)         Y except return  declaring                      no
# 4. Proc.new                     Y except return  declaring                      no
# 5. proc                         Y except return  declaring                      no
# 6. lambda                       Y                closure                        yes
# 7. method                       Y                closure                        yes
#
# The things within each of these groups are all semantically identical -- that is, they're
# different syntaxes for the same semantics:
#   
#      1. block (called with yield)
#      2. block (&b  =>  f(&b)  =>  yield)  
#      -------
#      3. block (&b  =>  b.call)
#      4. Proc.new  
#      5. proc
#      -------
#      6. lambda    
#      7. method
#
# Or at least, this is how I *think* it is, based on experiment. There's no authoritative answer
# other than testing the CRuby implementation, because there's no real spec -- see rant above -- so
# there may be other differences I haven't discovered.
#
# The final verdict: Ruby has three types of closures and near-closures, expressible in seven
# syntactic variants. Not pretty. But you sure sure do cool stuff with them! That's up next....
#
# This concludes the "Ruby makes Paul agitated" portion of our broadcast; from here on, it will be
# the "Ruby is awesome" portion.

 
# ---------------------------- Section 7: Doing Something Cool with Closures ----------------------------

# Let's make a data structure containing all of the Fibonacci numbers. Yes, I said *all* of them.
# How is this possible? We'll use closures to do lazy evaluation, so that the computer only
# calculates as much of the list as we ask for.

# To make this work, we're going to use Lisp-style lists: a list is a recursive data structure with
# two parts: "first," the next element of the list, and "rest," the remainder of the list.
#
# For example, the list of the first three positive integers is [1,[2,[3]]]. Why? Because:
#
#   [1,[2,[3]]]     <--- first=1, rest=[2,[3]]
#      [2,[3]]      <--- first=2, rest=[3]
#         [3]       <--- first=3, rest=nil
#
# Here's a class for traversing such lists:

example 18

class LispyEnumerable
  include Enumerable

  def initialize(tree)
    @tree = tree
  end

  def each
    iter = @tree
    until iter.nil?
      first, rest = iter
      yield first
      iter = rest
    end
  end
end

list = [1,[2,[3]]]
LispyEnumerable.new(list).each do |x|
  puts x
end

# So how to make an infinite list? Instead of making each node in the list a fully built data
# structure, we'll make it a closure -- and then we won't call that closure until we actually need
# the value. This applies recursively: the top of the tree is a closure, and its rest is a closure,
# and the rest's rest is a closure....

example 19

class LazyLispyEnumerable
  include Enumerable

  def initialize(tree)
    @tree = tree
  end

  def each
    while @tree
      first,rest = @tree.call  # <--- @tree is a closure
      yield first
      @tree = rest
    end
  end
end

list = lambda{[1, lambda {[2, lambda {[3]}]}]}  # same as above, except we wrap each level in a lambda
LazyLispyEnumerable.new(list).each do |x|
  puts x
end

example 20

# Let's see when each of those blocks gets called:
list = lambda do
  puts "first lambda called"
  [1, lambda do
    puts "second lambda called"
    [2, lambda do
      puts "third lambda called"
      [3]
    end]
  end]
end

puts "List created; about to iterate:"
LazyLispyEnumerable.new(list).each do |x|
  puts x
end

# Now, because the lambda defers evaluation, we can make an infinite list:

example 21

def fibo(a, b)
  lambda { [a, fibo(b,a+b)] }  # <--- this would go into infinite recursion if it weren't in a lambda
end

LazyLispyEnumerable.new(fibo(1,1)).each do |x|
  puts x
  break if x > 100  # we don't actually want to print all of the Fibonaccis!
end

# This kind of deferred execution is called "lazy evaluation" -- as opposed to the "eager
# evaluation" we're used to, where we evaluate an expression before passing its value on. (Most
# languages, including Ruby, use eager evaluation, but there are languages (like Haskell) which use
# lazy evaluation for everything, by default! This only makes sense in value-typed languages where
# evaluation order doesn't matter. End aside.)
#
# Though cool, this way of implementing lazy evaluation is terribly clunky! We had to write a
# separate LazyLispyEnumerable that *knows* we're passing it a special lazy data structure. How
# unsatisfying! Wouldn't it be nice of the lazy evaluation were invisible to callers of the lazy
# object?
#
# As it turns out, we can do this. We'll define a class called "Lazy," which takes a block, turns it
# into a closure, and holds onto it without immediately calling it. The first time somebody calls a
# method, we evaluate the closure and then forward the method call on to the closure's result.

class Lazy
  def initialize(&deferred_value)
    @deferred_value = deferred_value
  end

  def value
    @value ||= @deferred_value.call
  end

  def method_missing(method, *args, &block)
    value.send(method, *args, &block)
  end
end

def lazy(&b)
  Lazy.new &b
end

# This basically allows us to say:
#
#   lazy { value }
# 
# ...and get an object that *looks* exactly like value -- except that value won't be created until
# the first method call that touches it. It creates a transparent lazy proxy object. Observe:

example 22

x = lazy do
  puts "<<< Evaluating lazy value >>>"
  "lazy value"
end

puts "x has now been assigned"
puts "About to call one of x's methods:"
puts "x.size: #{x.size}"          # <--- .size triggers lazy evaluation
puts "x.swapcase: #{x.swapcase}"

# So now, if we define fibo using lazy instead of lambda, it magically works with our original
# LispyEnumerable -- which has no idea it's dealing with a lazy value!

example 23

def fibo(a, b)
  lazy { [a, fibo(b, a + b)] }
end

LispyEnumerable.new(fibo(1,1)).each do |x|
  puts x
  break if x > 100  # we don't actually want to print all of the Fibonaccis!
end

# Fantastic! We just traversed an infinite list like that's totally a normal thing that people do.
#
# And of course it works with finite lists too...right?

example 24

def fibo_up_to_max(a, b, max)
  lazy { [a, fibo_up_to_max(b, a + b, max)] if a <= max }
end

puts "List created; about to iterate:"
LispyEnumerable.new(fibo_up_to_max(1, 1, 100)).each do |x|
  puts x
end

# Wait ... what’s that thing doing at the end there?
#
# Well, the thing at end of the list is a lazy nil: fibo_up_to_max always returns a lazy value,
# and that lazy value happens to be nil when the "if" condition is false.
#
# The failure happens when this line of LispyEnumerable encounters that lazy nil:
#
#      first, rest = iter
#
# Let's zoom in on that:

example 24

first, rest = nil
puts "Regular nil: first=#{first}  rest=#{rest}"

first, rest = lazy { nil }
puts "Lazy nil:    first=#{first}  rest=#{rest}"

# Here's the problem. When we do this:
#
#   x,y = z
#
# ...Ruby wants to know whether z is an array, like this:
#
#   x,y = [0,1]  # x=0, y=1
#
# ...or something else:
#
#   x,y = 0      # x=0, y=nil
#
# So Ruby calls z.respond_to?(:to_ary) to see if z would like to behave as an array. If so, Ruby
# will do the multiple assignment; if not, it will just set x=z and y=nil.
#
# We want our Lazy to forward the respond_to? call to our fibo list. But it doesn't forward it,
# because we used the method_missing to do the proxying -- and every Object implements respond_to?
# by default, so the method isn't missing! The respond_to? doesn't get forwarded; instead, out Lazy
# says "No, I don't respond to to_ary; thanks for asking."
#
# The obvious solution would be to forward respond_to? manually, but there’s an even better one.
# The class called "Object" is not the root of Ruby's type hierarchy. It has a superclass:

example 26

p Object.superclass

# BasicObject implements just the bare minimum of methods, without all the helpful default
# behaviors of Object. And guess what the "bare minimum" doesn't include? Our friend "respond_to?"!
# That means that if we make BasicObject the superclass of Lazy, then respond_to? is missing, it
# will be handled by method_missing, and everything will just work!

Object.send(:remove_const, :Lazy)  # nixes the previous class declaration

class Lazy < BasicObject  # <-- the fix
  def initialize(&deferred_value)
    @deferred_value = deferred_value
  end

  def value
    @value ||= @deferred_value.call
  end

  def method_missing(method, *args, &block)
    value.send(method, *args, &block)
  end
end

# And *now* our original Lispy enum will work:

example 27

LispyEnumerable.new(fibo_up_to_max(1, 1, 100)).each do |x|
  puts x
end

# Our lazy objects aren't quite perfectly invisible. They still, for example, don't behave nicely
# with ==:

example 28

puts lazy { 3 } == 3
puts 3 == lazy { 3 }

# Fixing this, and finding the other problems like it, I leave as a vexing exercise for the reader.


# ---------------------------- Section 8: Wrap-Up ----------------------------

# So sure, this was all entertaining -- but is it good for anything?
#
# Anybody who has ever used Ruby to iterate over a collection, define an ActiveRecord scope, or
# configure a Sinatra route knows the answer to that.
#
# What about the lazy proxies and infinite lists? Are those just toys? Honestly, I'm surprised Ruby
# projects don't use them more often. Suppose you have a resource-intensive object. Perhaps it
# requires a network or database call during creation, or it will use a lot of memory once it
# exists. And suppose that this object may or may not be used, but you don't know at the time it's
# created whether it ever will be. Making it lazy will prevent it from consuming resources until it
# needs to, without burdening other code with explicitly bringing it to life.
#
# OK, I'll stop making your brain hurt now. Hope this has been a bit enlightening! The experience
# of working it out certainly was for me.
#
# Cheers,
#
# Paul
