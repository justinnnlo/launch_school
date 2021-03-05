class Series
  def initialize(str)
    @str = str
  end

  def slices(n)
    raise ArgumentError if n > @str.length
    result = []

    (0..(@str.length - n)).each do |index|
      temp = []
      (index...index + n).each do |i|
        temp << @str[i].to_i
      end
      result << temp
    end
    result
  end
end
