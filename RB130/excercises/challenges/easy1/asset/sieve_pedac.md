Problem: find all of the primes from 2 to the given number using the Sieves of Eratosthenes.

2 ways to approach this problem:
1. Arrays: convert a range into an array and remove non-prime elements
- Note: might be a bit of a hassle iteraring through elements that are disappearing
2. Hash: Create a key-value pair of each number from 2 to the limit
- Key: number
- Value: :P (prime), :N (non-prime)

Hash approach
- Instantiate a hash with default value :P
- Iterate through 2 to n — assign each number to a key and bind to :P
- Iterate from 2 to n
  - Multiply the current number by 2..n where n is the last pair which gives a product less than the limit
    - E.g.
      - Limit: 1000
      - Current number: 2
      - Maximum pair: 500
      - Last comparison: 1002
  - Mark said number as :N
- Select all keys that have a value :P and return as arrays

Array approach
- Convert a range from 2..limit to an array
- Iterate through each element of the array
  - Multiply the current number by 2..n where n is the last pair which gives a product less than the limit
  - Delete each product from the array
- Return the new array
