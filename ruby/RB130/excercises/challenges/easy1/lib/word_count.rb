class Phrase
  def initialize(str)
    @str = str
  end

  def word_count
    count = Hash.new { 0 }

    arr = @str.split(/[, ]/).map do |w|
      w.gsub(/(^['\n]?|[^a-zA-Z']|['\n]?$)/, "")
    end
    arr = arr.reject { |w| w == "" || w.include?(":") }
    arr.each { |w| count[w.downcase] += 1 }
    count
  end
end
