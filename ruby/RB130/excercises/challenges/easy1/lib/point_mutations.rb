class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(comparison)
    limit = (@strand.size > comparison.size ? comparison.size : @strand.size)

    (0...limit).inject(0) { |a, i| @strand[i] != comparison[i] ? a + 1 : a }
  end
end
