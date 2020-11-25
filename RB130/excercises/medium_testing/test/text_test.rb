require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!

require_relative "../lib/text.rb"

class TextTest < Minitest::Test
  def setup
    @text = Text.new(File.new("/Users/jadlp/repos/launch_school/RB130/excercises/medium_testing/assets/sample_text.txt").read, File.new("/Users/jadlp/repos/launch_school/RB130/excercises/medium_testing/assets/sample_text.txt"))
  end

  def teardown
    @text.file.close if @text.file != nil
    puts "File has been closed: #{@text.file.closed?}"
  end

  def test_swap
      solution = <<~HEREDOC
      Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
      Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
      quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
      nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
      dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
      et verius meuris, et pheretre mi.
      HEREDOC

    assert_equal(solution.chomp, @text.swap("a", "e"))
  end

  def test_word_count
    assert_equal(72, @text.word_count)
  end
end