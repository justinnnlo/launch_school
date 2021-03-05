# class Machine
#   def start
#     self.flip_switch(:on)
#   end

#   def stop
#     self.flip_switch(:off)
#   end

#   private

#   attr_writer :switch

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end



# class FixedArray
#   def initialize(length)
#     @array = Array.new(5)
#   end

#   def [](num)
#     @array.fetch(num)
#   end

#   def to_a
#     @array
#   end

#   def []=(num, value)
#     self[num]
#     @array[num] = value
#   end

#   def to_s
#     @array.to_s
#   end
# end

# fixed_array = FixedArray.new(5)
# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end



# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end

#   def greet
#     "Hi there!"
#   end
# end

# class Graduate < Student
#   def initialize(name, year, parking)
#     super(name, year)
#     @parking = parking
#   end

#   def greet
#     super() + " My name is #{@name}."
#   end
# end

# class Undergraduate < Student; end

# p Graduate.new("Jose", 2018, true).greet



=begin
Note: nil represents empty spots; no item inserted will be nil
Algorithm
- enqueue
  - If the array is not full: add an element in the next place that is nil
    - Select the first element that is nil
  - If the array is full
    - Counter starts at 0
    - Reassign the element of index counter with the parameter passed
    - Increase the counter by 1 if counter < size of the array
      - Else, counter = 0

- dequeue
  - counter starts at 0
  - Reassign element ar index counter with nil
  - Return the element that was previously assigned
    - Increase the counter by 1 if counter < size of the array
    - Else, counter = 0
=end

require "byebug"

# class QueuedObject
#   attr_reader :value, :time

#   def initialize(value)
#     @value = value
#     @time = Time.now
#   end

#   def to_s
#     self.value.to_s
#   end
# end

# class CircularQueue
#   attr_reader :queue

#   def initialize(length)
#     @queue = Array.new(length)
#     @current = 0
#   end

#   def enqueue(ele)
#     @queue[@current] = QueuedObject.new(ele)
#     @current < @queue.length - 1 ? @current += 1 : @current = 0
#   end

#   def dequeue
#     oldest = @queue.select { |ele| ele.class == QueuedObject }.inject { |acc, obj| acc.time < obj.time ? acc : obj }
#     @queue[@queue.find_index(oldest)] = nil
#     oldest.value unless oldest == nil
#   end

#   def to_a
#     @queue.map { |ele| ele.to_s }.to_s
#   end
# end



# queue = CircularQueue.new(3)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil



class GuessingGame
  def initialize(low = 1, high = 100)
    @range = (low..high)
  end

  def reset
    @answer = rand(@range)
    @remaining_guesses = Math.log2((@range).size).to_i + 1
    @guess = nil
  end

  def display_remaining_guesses
    puts "You have #{@remaining_guesses} guesses remaining."
  end

  def get_player_guess
    loop do
      puts "Enter a number between #{@range.min} and #{@range.max}: "
      @guess = gets.chomp.to_i
      break if @range === @guess
      puts "Invalid guess."
    end
  end

  def evaluate_player_guess
    if @guess == @answer
      puts "That is the number!"; true
    else
      @remaining_guesses -= 1
      puts (@guess > @answer) ? "Your guess is too high.\n\n" : "Your guess is too low.\n\n"
    end
  end

  def player_guess
    display_remaining_guesses
    get_player_guess
    evaluate_player_guess
  end

  def display_game_result
    puts (@guess == @answer) ? "You win!" : "You have no more guesses. You lost! The answer was #{@answer}."
  end

  def play
    reset
    system("clear")
    while @remaining_guesses > 0
      break if player_guess
    end
    display_game_result
  end
end

# game = GuessingGame.new(501, 1500)
# game.play



# Problem: return the lowest and highest ranking cards in an array of card objects. Ranks is determined by number (2..Ace) — suit is irrelevant
# If 2 cards of the same rank: fetch either, irrelevant which one
# Additionally: return a string representation of to_s

class Card
  attr_reader :rank, :suit
  TRANSLATOR = { 2 => 2, 3 => 3, 4 => 4, 5 => 5,
                 6 => 6, 7 => 7, 8 => 8, 9 => 9,
                 10 => 10, "Jack" => 11, "Queen" => 12,
                 "King" => 13, "Ace" => 14
               }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    TRANSLATOR[@rank] <=> TRANSLATOR[other.rank]
  end

  def to_s
    "#{@rank} of #{@suit}"
  end

  def ==(other)
    TRANSLATOR[@rank] == TRANSLATOR[other.rank]
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8



class Deck
  attr_reader :deck

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset_deck
  end

  def reset_deck
    @deck = RANKS.each_with_object([]) do |rank, arr|
      SUITS.each { |suit| arr << Card.new(rank, suit) }
    end
  end

  def draw
    card = @deck.sample
    @deck.delete_if { |ele| ele.rank == card.rank && ele.suit == card.suit }
    reset_deck if @deck.length == 0
    card
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2

# Include Card and Deck classes from the last two exercises.

class PokerHand
  attr_accessor :suits, :rank
  def initialize(deck)
    @deck = deck
    @hand = []; 5.times { @hand << @deck.draw }
    @suits = @hand.map { |card| card.suit }
    @rank = @hand.map { |card| Card::TRANSLATOR[card.rank] }
  end

  def print
    puts @hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    @suits.uniq.length == 1 && @rank.include?(14) && @rank.include?(13) && @rank.include?(12) && @rank.include?(11) && @rank.include?(10)
  end

  def straight_flush?
    min, max = @rank.min, @rank.max
    @rank.sum == [*min..max].sum && @suits.uniq.length == 1
  end

  def four_of_a_kind?
    @rank.each_with_object(Hash.new { 0 }) { |ele, hash| hash[ele] += 1 }.values.include? 4
  end

  def full_house?
    @rank.each_with_object(Hash.new { 0 }) { |ele, hash| hash[ele] += 1 }.values.include?(3) && @rank.uniq.length == 2
  end

  def flush?
    @suits.uniq.length == 1
  end

  def straight?
    min, max = @rank.min, @rank.max
    @rank.sum == [*min..max].sum
  end

  def three_of_a_kind?
    @rank.each_with_object(Hash.new { 0 }) { |ele, hash| hash[ele] += 1 }.values.include? 3
  end

  def two_pair?
    @rank.each_with_object(Hash.new { 0 }) { |ele, hash| hash[ele] += 1 }.values.count(2) == 2
  end

  def pair?
    @rank.each_with_object(Hash.new { 0 }) { |ele, hash| hash[ele] += 1 }.values.include? 2
  end
end

# hand = PokerHand.new(Deck.new)
# p hand.print
# byebug
# p hand.evaluate

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
#byebug
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'