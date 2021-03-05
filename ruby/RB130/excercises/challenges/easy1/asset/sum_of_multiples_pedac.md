Input: integer
Output: integer

Problem: add all of the multiples of the number (except itself)

Ifn o numbers are given, default to 3 and 5

Algorithm
- Create result and bind to 0
- For 3 and 5
  - Start counter at 1
  - Loop by adding result to num * counter
  - Stop loop when num * counter >= limit

- 1: 0
- 4: 3
- 10: 3, 5, 6, 9 = 23