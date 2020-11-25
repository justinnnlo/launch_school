class Trinary
  def initialize(trinary)
    @trinary = trinary
  end

  def to_decimal
    return 0 if @trinary.match(/[^012]/)
    result = 0
    arr = @trinary.chars

    arr.each_with_index { |n, i| result += (n.to_i * 3**(arr.size - 1 - i)) }
    result
  end
end
