Input: string
Output: integer

Problem: convert a trinary number to its decimal equivalent. If invalid trinary, return 0

Trinary numbers:
- Can only contain 0, 1, and 2

Conversion from trinary to decimal

"102012"
    1       0       2       0       1       2    # the number
1*3^5 + 0*3^4 + 2*3^3 + 0*3^2 + 1*3^1 + 2*3^0    # the value
  243 +     0 +    54 +     0 +     3 +     2 =  302

Algorithm:
- Return 0 if any character is NOT 0, 1 or 2
- Create a result variable and bind to 0
- Iterate through each character
  - Multiply the current number (as int) times 3 ** (length - 1 - i)
  - Add the product to result
- Return the result