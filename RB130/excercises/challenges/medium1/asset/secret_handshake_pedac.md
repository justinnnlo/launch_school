Input: decimal number or string of binary
Output: Array of strings

Problem: convert the decimal number into an appropriate sequence of events

1 = wink
10 = double blink
100 = close your eyes
1000 = jump
10000 = Reverse the order of the operations in the secret handshake.

PENDING: how to convert decimal to binary?

Algorithm
- If an integer is inputted: convert to binary string
  - Otherwise: if it's a string convert to integer and again to string and use that as the binary
- Create an empty array
  - Iterate through each character of the binary string
  - If length is 5, reverse the final output
  - If the current element as int equals 1, pass the length - index
    - Place the returned value into the array

{ 4 => "jump", 3 => "close your eyes", 2 => "double blink", 1 => "wink" }

# Binary conversion
4 / 2 = 2 remainder 0
2 / 2 = 1 remainder 0
1 / 2 = 0 remainder 1

5 / 2 = 2 remainder 1
2 / 2 = 1 remainder 0
1 / 2 = 0 remainder 1

6 / 2 = 3 remainder 0
3 / 2 = 1 remainder 1
1 / 2 = 0 remainder 1

7 / 2 = 3 remainder 1
3 / 2 = 1 remainder 1
1 / 2 = 0 remainder 1

8 / 2 = 4 remainder 0
4 / 2 = 2 remainder 0
2 / 2 = 1 remainder 0
1 / 2 = 0 remainder 1

9 / 2 = 4 remainder 1
4 / 2 = 2 remainder 0
2 / 2 = 1 remainder 0
1 / 2 = 0 remainder 1

10 / 2 = 5 remainder 0
5 / 2 = 2 remainder 1
2 / 2 = 1 remainder 0
1 / 2 = 0 remainder 1

