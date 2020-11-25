class PerfectNumber
  def self.classify(num)
    raise StandardError, "Invalid number" if num < 0
    factors = []

    1.upto(num / 2) { |n| factors << n if (num % n).zero? }

    if factors.sum == num
      "perfect"
    elsif factors.sum > num
      "abundant"
    else
      "deficient"
    end
  end
end
