Input: 2 strings
  - Each string represents a version number
  - Numbers should be compared left-to-right, with decimal point as the separator
Output:
  - 1: if verion 1 > version 2
  - -1: if verion 1 < version 2
  - 0: if verion 1 === version 2
    - `1 === 1.0` returns `true`
  - null: if iether version contains any characters that aren't digits or '.'

Algorithm
- Return `null` if either string contains any non-digit or `.` character
- Split each string via `.`
  - If the arrays have different lengths, push `0` to the shortest array until it has the length of the other array => is this necessary?
- Use a for loop to iterate through an array
  - If its current number is greater than the other one at the same index location, return 1
  - If the reverse if true, return -1
  - If equal, continue to the next
    - If at the end, return 0