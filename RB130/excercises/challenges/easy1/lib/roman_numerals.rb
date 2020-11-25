class Integer
  def to_roman
    to_ten = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX']
    to_hundered = ['X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC']
    to_thousand = ['C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM']
    thousand = ['M', 'MM', 'MMM']
    hash = { 4 => thousand, 3 => to_thousand, 2 => to_hundered, 1 => to_ten }
    arr = self.to_s.chars

    arr.each_with_index.map do |ele, ind|
      hash[arr.length - ind][ele.to_i - 1] unless ele.to_i.zero?
    end.join
  end
end
