=begin

Input: integer
Output: Boolean

- Count from the rightmost digit and move left
- Double the value of every 2nd digit
- Subtract 9 from any digit that becomes 10 or more
  - 8763 => 8 * 2 = 16 - 9 = 7; 6 * 2 = 12 - 9 = 3 => 7733
- Add all the numbers together – IT'S VALID IF FTHE # ENDS IN 0
  - 7733 = 7 + 7 + 3 + 3 = 20


=end

class Luhn
  def initialize(num)
    @num = num
  end

  def self.create(num)
    Luhn.new(num)
  end

  def checksum
  end

  def addends
  end

  def valid?
  end

end