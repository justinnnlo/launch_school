class Anagram
  def initialize(str)
    @str = str
    @str_hash = Anagram.to_h(str.downcase)
  end

  def match(arr)
    arr.select do |w|
      Anagram.to_h(w.downcase) == @str_hash unless @str.downcase == w.downcase
    end.sort
  end

  def self.to_h(word)
    word.chars.each_with_object(Hash.new(0)) { |el, obj| obj[el] += 1 }
  end
end
