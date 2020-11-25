class BeerSong
  def initialize
    @file = File.new("/Users/jadlp/repos/launch_school/RB130/excercises/challenges/easy2/assets/beer_song.txt")
    @text = @file.read
    @file.close
  end

  def verse(num)
    @text.split("\n\n").reverse[num] + "\n"
  end

  def verses(start, ending)
    result = ""
    (ending..start).each do |n|
      n != ending ? result.prepend(verse(n) + "\n") : result.prepend(verse(n))
    end
    result
  end

  def lyrics
    @text + "\n"
  end
end
