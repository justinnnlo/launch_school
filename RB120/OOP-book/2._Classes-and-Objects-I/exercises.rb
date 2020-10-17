=begin
1. Create a **class called MyCar**.

When you initialize a new instance or object of the class, **allow the user to define instance variables that tell us the
- year
- color
- model of the car

Also track the current speed of the car and set it to 0 during instantiation.

Create instance methods that allow the car to
- speed up
- brake
- shut the car off
=end

class MyCar

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def shut_off
    @current_speed = 0
  end

  def speed_up(acceleration)
    @current_speed += acceleration
  end

  def brake(deceleration)
    @current_speed -= deceleration
  end

end

=begin
2. Add an accessor method to your MyCar class to **change and view the color of your car**. Then add an accessor method that allows you to view, but not modify, the year of your car.
=end

class MyCar

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def shut_off
    @current_speed = 0
  end

  def speed_up(acceleration)
    @current_speed += acceleration
  end

  def brake(deceleration)
    @current_speed -= deceleration
  end

  def year
    @year
  end

  def color
    @color
  end

  def color=(new_color)
    @color = new_color
  end

end

=begin
3. You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.
=end

class MyCar

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def shut_off
    @current_speed = 0
  end

  def speed_up(acceleration)
    @current_speed += acceleration
  end

  def brake(deceleration)
    @current_speed -= deceleration
  end

  def year
    @year
  end

  # def color
  #   @color
  # end

  def color=(new_color)
    @color = new_color
  end

  def spray_paint(new_color)
    self.color = new_color
  end
end


class MyCheese
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def display_name
    self.name
  end
end

my_cheese = MyCheese.new("Camembert")
p my_cheese.display_name

def bad_luck
  puts "No luck"
end

def prints
  bad_luck
end


class Person
  attr_writer :first_name, :last_name

  def full_name
    self.first_name + ' ' + self.last_name
  end
end

mike = Person.new
mike.first_name = 'Michael'
mike.last_name = 'Garcia'
mike.full_name # => 'Michael Garcia'

# "Animal"


