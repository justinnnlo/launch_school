class TextAnalyzer
  def process
    file = File.new("sample_text.txt")
    yield(file.read)  # IO#read method
    file.close
  end
end


analyzer = TextAnalyzer.new
analyzer.process { |text| puts text.split(/\n\n/).count } # Paragraphs
analyzer.process { |text| puts text.split(".").count }    # Sentences
analyzer.process { |text| puts text.split("\n").count }   # Lines
analyzer.process { |text| puts text.split(" ").count }    # Words
p analyzer.process { |text| text.class }
