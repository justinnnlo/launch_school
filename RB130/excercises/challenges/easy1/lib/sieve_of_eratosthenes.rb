class Sieve
  def initialize(limit)
    @limit = limit
  end

  def primes
    arr = (2..@limit).to_a
    arr.each do |ele|
      multiple = 2

      while ele * multiple <= @limit
        arr.delete(ele * multiple)
        multiple += 1
      end
    end

    arr
  end
end
