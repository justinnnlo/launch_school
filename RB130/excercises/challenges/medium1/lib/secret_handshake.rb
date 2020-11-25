# Secret handhshake class
class SecretHandshake
  COMMAND_TRANSLATOR = {
    4 => 'jump', 3 => 'close your eyes',
    2 => 'double blink', 1 => 'wink'
  }.freeze
  def initialize(num)
    @num = SecretHandshake.to_binary(num)
  end

  def self.to_binary(num)
    return num.to_i.to_s if num.class == String

    binary = []

    loop do
      binary << (num % 2).to_s
      num /= 2
      break if num.zero?
    end
    binary.reverse.join
  end

  def commands
    arr = []

    @num.chars.each_with_index do |c, i|
      next if i.zero? && @num.length == 5

      arr << COMMAND_TRANSLATOR[@num.length - i] if c == '1'
    end
    @num.length == 5 ? arr : arr.reverse
  end
end
