Problem: calculate the Hamming distance between 2 DNA strands
- If 2 sequences are of unequal length, compute the Hamming distance over the shorter length
- Assumption: both are uppercase

Algorithm
- Create limit: local variable
  - If both strands have the same length: value of length
  - If one is larger: length of the smaller one
- Create distance local variable and bind to 0
- Iterate through 0...limit
  - distance += 1 if the slicing of both strings isn't the same