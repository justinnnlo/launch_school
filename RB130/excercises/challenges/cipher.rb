class Cipher
  ALPHABET = [*"a".."z"] + [*"A".."Z"]

  def self.rotate(str, num = 13)
    encrypted_str = ""

    str.each_char do |ch|
      encrypted_str << rotate_char(ch, num)
    end

    encrypted_str
  end

  def self.rotate_char(c, n)
    return c if !ALPHABET.include?(c)

    invalid_rotation(c, n) ? (c.ord + n - 26).chr : (c.ord + n).chr
  end

  def self.invalid_rotation(c, n)
    c.downcase == c && c.ord + n > 122 || c.upcase == c && c.ord + n > 90
  end
end
