class SumOfMultiples
  def initialize(*multiples)
    @multiples = multiples
  end

  def self.to(limit, multiples = [3, 5])
    result = []

    multiples.each do |ele|
      counter = 1

      while (ele * counter) < limit
        result << ele * counter
        counter += 1
      end
    end
    result.uniq.sum
  end

  def to(limit)
    SumOfMultiples.to(limit, @multiples)
  end
end
