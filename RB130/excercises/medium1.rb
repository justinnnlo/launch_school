=begin
- Record and save when something is said, to be stored for later use
  - "Something is said": return value of block

Algorithm:
- Assumption: no nil values
  - if yield returns somethinig with size > 0: record
  - Play: puts array
=end

class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def play
    puts @recordings.last
  end

  def listen
    record(yield) if (block_given? && yield.size > 0)
  end
end

p listener = Device.new
p listener.listen { "Hello World!" }
p listener.listen
p listener.play # Outputs "Hello World!"



=begin
1. Create a new `file` local variable and bind it to a new instance of `File` that points to the specified file
2. Yield the readable file to the block using i0#read
2. Pass the file as a string to the block yield
3. Manipulate the string in each situation to get the desired result
=end

class TextAnalyzer
  def process
    file = File.new("sample_text.txt")
    yield(file.read)  # IO#read method returns the file as a string
    file.close        # WHY? Unclear
  end
end


analyzer = TextAnalyzer.new
puts analyzer.process { |text| text.split(/\n\n/).count } # Paragraphs
puts analyzer.process { |text| text.split(".").count }    # Sentences
puts analyzer.process { |text| text.split("\n").count }   # Lines
puts analyzer.process { |text| text.split(" ").count }    # Words



=begin
Move the display of items to a block
=end

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Nice selection of food we have gathered!"
end

gather(items) { |produce| puts "We've gathered some vegetables: #{produce[1]} and #{produce[2]}" }
gather(items) { |items| puts items.join(", ") }



=begin
1. Take an array as an argument
2. Yield the array to a block
3. Group all elements but the first 2 using a splat operator
=end

def pass_parameter(arr)
  yield(arr) if block_given?
end

p pass_parameter(%w(raven finch hawk eagle)) { |arr| *contents = arr[2..-1] }
p pass_parameter(%w(raven finch hawk eagle)) { |_, _, *raptors| "Raptors: #{raptors.join(", ")}" }



=begin

=end

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |*first, second|
  puts first.join(", ")
  puts second
end

gather(items) do |first, *second, third|
  puts first
  puts second.join(", ")
  puts third
end

gather(items) do |first, *rest|
  puts first
  puts rest.join(", ")
end

gather(items) do |first, second, third, fourth|
  puts "#{first}, #{second}, #{third}, and #{fourth}"
end



=begin

=end