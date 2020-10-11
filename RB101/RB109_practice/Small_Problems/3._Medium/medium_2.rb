require "byebug"

=begin

Problem:
  - Read the content of a text file
  - Print the longest sentence in the file and its number of words
    - Criteria: # of WORDS
    - Sentences end with ".", "!", or "?"
    - A word is delimited by " " at the end

Algorithm
  - file = the full text file
  - Split the file by
    - Sentences (split(".")) and initialize to sentences
    - Initialize "longest_sentence" and "words" and set to "" and 0
    - Then iterate through each sentence
      - split sentences into words(split(" "))
      - If word count > "words"
        - longest_sentence = current sentence
        - words = current # of words
      - Else
        - next
  - Print longest_sentence and words
=end

string = "Four score and seven years ago our fathers brought forth
on this continent a new nation, conceived in liberty, and
dedicated to the proposition that all men are created
equal.

Now we are engaged in a great civil war, testing whether
that nation, or any nation so conceived and so dedicated,
can long endure. We are met on a great battlefield of that
war. We have come to dedicate a portion of that field, as
a final resting place for those who here gave their lives
that that nation might live. It is altogether fitting and
proper that we should do this.

But, in a larger sense, we can not dedicate, we can not
consecrate, we can not hallow this ground. The brave
men, living and dead, who struggled here, have
consecrated it, far above our poor power to add or
detract. The world will little note, nor long remember
what we say here, but it can never forget what they
did here. It is for us the living, rather, to be dedicated
here to the unfinished work which they who fought
here have thus far so nobly advanced. It is rather for
us to be here dedicated to the great task remaining
before us -- that from these honored dead we take
increased devotion to that cause for which they gave
the last full measure of devotion -- that we here highly
resolve that these dead shall not have died in vain
-- that this nation, under God, shall have a new birth
of freedom -- and that government of the people, by
the people, for the people, shall not perish from the
earth."

def longest_sentence(string)
  sentences = string.split(/[.?!]/)
  longest_sentence, words = ["", 0]

  sentences.each do |s|
    if words <= s.split(" ").count
      words = s.split(" ").count
      longest_sentence = s
    else
      next
    end
  end

  puts "The words of the longest sentence are #{words} and it says:"
  puts longest_sentence
end

longest_sentence(string)

=begin

Input: string
Output: boolean

{ "B:O" => 0 }

Algorithm
  - Initialize hash: string pair => 0
    - Number counts the # of times the block of letter has been used
  - Loop through the string
    - For each character of the string
      - Do key = hash.keys.bsearch { |k| k.include?(c) } where c is the current character
        - This returns the pair
      - hash[key] += 1
    - hash.values.all? { |v| v < 2 }

=end

def block_word?(string)
  hash = { "B:0" => 0, "X:K" => 0, "D:Q" => 0, "C:P" => 0,
           "N:A" => 0, "G:T" => 0, "R:E" => 0, "F:S" => 0,
           "J:W" => 0, "H:U" => 0, "V:I" => 0, "L:Y" => 0,
           "Z:M" => 0
         }

  string.each_char do |char|
    #byebug
    index = hash.keys.find_index { |k| k.include?(char.upcase) }
    key = hash.keys[index] #Slicing works with chaining
    hash[key] += 1
  end

  hash.values.all? { |v| v < 2 }
end

p block_word?('BATCH') == true
p block_word?('BUTCH') == false
p block_word?('jest') == true


=begin

Input: string

Output: hash with 3 key-value pairs
  - lowercase, uppercase, neither
  - Each expresses the % of said characters
  - Values should be floats!

Assumption: string will contain at least 1 character

Algorithm
- Initialize hash with the 3 k/v pairs set to 0
- Do an each_char loop on the string
  - If ord value between 65 and 90 — uppercase +1
  - If ord value between 97 and 122 — lowercase +1
  - Else: neither +1
- hash map: each value / hash.values.sum

=end

# Key mistake! Creating a new hash with hash#map — which creates an array!

def letter_percentages(string)
  hash = { lowercase: 0, uppercase: 0, neither: 0}

  string.each_char do |char|
    if char.ord >= 65 && char.ord <= 90
      hash[:uppercase] += 1
    elsif char.ord >= 97 && char.ord <= 122
      hash[:lowercase] += 1
    else
      hash[:neither] += 1
    end
  end

  percentages = {}
  hash.each { |k, v| percentages[k] = ((v.to_f/hash.values.sum) * 100).ceil(2) }
  percentages
end

p letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
p letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
p letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }
p letter_percentages("abcdefGHI")


=begin

Input: string

Output: boolean

Problem: is the string balanced? A string is balanced if it has the correct matching parentheses
- Initialize an empty array
- Look through the string and when it's a parentheses append it to the empty array
- Join the array and chain it to squeeze("()")
  - Squeeze doesn't work with multiple chars? Seem so, at least it's faulty
- 



=end