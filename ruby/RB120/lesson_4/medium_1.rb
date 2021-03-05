class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Solution: In line 9 the balance getter method is called and returns a boolean.
# How would it be wrong? If instead of a comparison, we would be using an assignment operator. In that case, balance would be a local variable.



class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0  # Needs @ before quantity
  end
end

test = InvoiceEntry.new("Dogs", 100)
test.update_quantity(10)
p test.quantity

# Problem: quantity is a local variable — not the instance variable!
# With a setter method: would have to be self.quantity!



# Problem with changing the above code to self.quantity using attr_accessor: loosens the protections of the code
# Implication: users would be able to change @quantity through the instance.quantity= method



class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

test = Hello.new
test.hi
test = Goodbye.new
test.bye



class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    #((@filling_type == nil ? "Plain" : @filling_type) + " " + (@glazing == nil ? "" : @glazing)).strip
    "#{(@filling_type == nil ? "Plain" : @filling_type)} #{@glazing}".strip
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
#  => "Plain"

puts donut2
#  => "Vanilla"

puts donut3
#  => "Plain with sugar"

puts donut4
#  => "Plain with chocolate sprinkles"

puts donut5
#  => "Custard with icing"



class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# No difference: both codes perform exactly the same
# Initializations: @template is equivalent to self.template = — ie, calling the object's template= method to set the instance variable
# show_template method: calling the instance method via `template` and `self.template` is the same. When wouldn't it be? If there's a `template` local variable

# Caveat: avoid `self` unless required!



class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end

# Change self.light_status to self.status — ie light.light_status to light.status