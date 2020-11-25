require "byebug"
class Octal
  def initialize(octal)
    @octal = octal
  end

  def invalid_octal?
    @octal.include?("8") || @octal.include?("9") ||
      @octal.chars.any? { |d| d.ord < 48 || d.ord > 57 }
  end

  def to_decimal
    return 0 if invalid_octal?
    result = 0
    arr = @octal.to_i.to_s.chars

    arr.each_with_index { |n, i| result += (n.to_i * 8**(arr.size - i - 1)) }
    result
  end
end
