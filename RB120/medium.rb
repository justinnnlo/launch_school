require "byebug"

class Machine

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

#Machine.new.switch


class FixedArray
  def initialize(ele)
    @array = Array.new(ele)
  end

  def []=(num, ele)
    self[num]
    @array[num] = ele
  end

  def [](num)
    @array.fetch(num)
  end

  def to_a=(array)
    @array = array if @size == array.length
  end

  def to_a
    @array
  end

  def to_s
    @array.to_s
  end
end


#byebug
fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']

puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

# puts fixed_array[7]
# puts fixed_array



class Student
  def initialize(name, year)
    @name = name
    @year = year
  end

  def greeting
    "Hello there!"
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end

  def greeting
    super() + " I'm a graduate student"
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super(name, year)
  end
end

jose = Graduate.new("Jose", 2018, true)
p jose
p jose.greeting

loren = Undergraduate.new("Lorenzo", 2022)
p loren


