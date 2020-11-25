Problem: given a word, compute the word's scrabble score

Value of 1: A, E, I, O, U, L, N, R, S, T
Value of 2: D, G
Value of 3: B, C, M, P
Value of 4: F, H, V, W, Y
Value of 5: K
Value of 8: J, X
Value of 10: Q, Z

Assumption: invalud input is 0

Algorithm
- Create a points var and point to 0
- Create a hash with each letter as key pointint to its score
- Iterate through each char
  - Place current ch in uppercase in values hash and add that to points var
- Return points