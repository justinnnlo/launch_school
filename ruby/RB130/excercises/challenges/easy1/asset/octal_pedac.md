Problem: convert octals (Base-8) to decimals (Base-10)

Input: octal input string
Output: decimal output

Assumptions:
- Treat invalid input as octal 0

What is base 10?

233

(2 * 10^2) + (3 * 10^1) + (3 * 10^0)
(2 * 100 ) + (3 * 10  ) + (3 * 1   )
200        + 30         + 3
= 233

What is base 8?

233

(2 * 8^2) + (3 * 8^1) + (3 * 8^0)
(2 * 64 ) + (3 * 8  ) + (3 * 1   )
128       + 24        + 3
= 155

Examples (octal ti decimal)
- 10 = 1 * 8^1 + 0 * 8 ^ 0 = 8 + 0 = 8
- 17 = 1 * 8^1 + 7 * 1 = 8 + 7 = 15
- 11 = 1 * 8^1 + 1 * 8^0 = 8 + 1 = 9
- 7777 = 7 * 8^3 + 7 * 8^2 + 7 * 8^1 + 7 * 8^0 = 3584 + 448 + 56 + 7 = 4095


7777
Length: 4
7[0] * 3 + 7[1] * 2 + 7[2] * 1 + 7[3] * 0

Length - 1 - arr_position

Algorithm
- Create a new variable to take the output
- Iterate through each character with index (as array)
  - Convert the current number to int
  - Multiply the number times 8 ^ (arr_length - 1 - arr_position)
  - Append product to new array
- Join new array and convert to int