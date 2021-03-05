Problem: translate an integer to roman numerals

Input: integer
Output: string

I = 1
V = 5
X = 10
L = 50
C = 100
D = 500
M = 1000

Algorithm
=> Gist: use the decimal system
- Turn the number into a string array and save to a variable
- Iterate through the string array
  - Place in hash with value arr length - index and slice the arr with the element's value
  - Append the return value and then join


Exmples:
- 1: TO_TEN[1-1] => I
- 2: TO_TEN[2-1] => II
- 3: TO_TEN[3-1] => III
- 4: TO_TEN[4-1] => IV
- 5: TO_TEN[5-1] => V
- 6: TO_TEN[6-1] => VI
- 7: TO_TEN[7-1] => VII
- 8: TO_TEN[8-1] => VIII
- 9: TO_TEN[9-1] => IX
- 27:
  - Length = 2
    - 
- 1024 -> split into chars and pass
  - 1 * 10 ^ 3 => Length 4    Length - i = 4 - 0 = 4
  - 0 * 10 ^ 2 => Length 3    Length - i = 4 - 1 = 3
  - 2 * 10 ^ 1 => Length 2    Length - i = 4 - 2 = 2
  - 4 * 10 ^ 0 => Length 1    Length - i = 4 - 3 = 1
- 24
  - 2 * 10 ^ 1 => Length 2    Length - i = 2 - 0 = 2
  - 4 * 10 ^ 0 => Length 1    Length - i = 2 - 1 = 1

hash[]

4000
4 * 10 ^ 3 (size - i - 1)
M * 4 = MMMM