require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @toc = File.readlines("data/toc.txt")                     # Work from current directory, no starting "/"
end

helpers do
  def in_paragraphs(text)
    text.split("\n\n").each_with_index.map do |line, index|
      "<p id=paragraph#{index}>#{line}</p>"
    end.join
  end

  def highlight(text, term)
    text.gsub(term, "<strong>#{term}</strong>")
  end

  def each_chapter
    @toc.each_with_index do |name, index|
      number = index + 1
      contents = File.read("data/chp#{number}.txt")
      yield name, number, contents
    end
  end

  def chapters_matching(query)
    results = []

    return results unless query

    each_chapter do |name, number, contents|
      matches = {}
      contents.split("\n\n").each_with_index do |p, i|
        matches[i] = p if p.include?(query)
      end
      results << {number: number, name: name, paragraphs: matches} if matches.any?
    end

    results
  end
end

# 1. Iterate through each chapter and get the right paragraph
# 2. Add the paragraph in the HTML output

get "/" do
  erb :home
end

get "/search" do
  @results = chapters_matching(params[:query])
  erb :search
end

get "/chapters/:number" do
  number = params[:number].to_i                                  # params **gets** the part of the URL represented by :number
  redirect "/" unless ((1..@toc.size).cover?(number))       # Why doesn't redirect work if placed in line 22 and below?
  @text = File.read("data/chp#{number}.txt")
  @chapter_number = "Chapter #{number}"

  erb :chapters
end

not_found do
  redirect "/"
end

# get "/chapters/1" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp1.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 1"

#   erb :chapters
# end

# get "/chapters/2" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp2.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 2"

#   erb :chapters
# end

# get "/chapters/3" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp3.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 3"

#   erb :chapters
# end

# get "/chapters/4" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp4.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 4"

#   erb :chapters
# end

# get "/chapters/5" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp5.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 5"

#   erb :chapters
# end

# get "/chapters/6" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp6.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 6"

#   erb :chapters
# end

# get "/chapters/7" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp7.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 7"

#   erb :chapters
# end

# get "/chapters/8" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp8.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 8"

#   erb :chapters
# end

# get "/chapters/9" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp9.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 9"

#   erb :chapters
# end

# get "/chapters/10" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp10.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 10"

#   erb :chapters
# end

# get "/chapters/11" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp11.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 11"

#   erb :chapters
# end

# get "/chapters/12" do
#   @toc = File.readlines("data/toc.txt")
#   @text = File.read("data/chp12.txt").split(/\n\n/)
#   @title = "The Adventures of Sherlock Holmes"
#   @chapter_number = "Chapter 12"

#   erb :chapters
# end

# File.read provides the content as a string
# File.readlines provides content as array