class Text
  attr_accessor :text, :file
  def initialize(text, file = nil)
    @text = text
    @file = file
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end

  def word_count
    @text.split.count
  end
end

test = Text.new(File.new("/Users/jadlp/repos/launch_school/RB130/excercises/medium_testing/assets/sample_text.txt").read, File.new("/Users/jadlp/repos/launch_school/RB130/excercises/medium_testing/assets/sample_text.txt"))
puts test.text
puts test.file
puts test.swap("a", "e")