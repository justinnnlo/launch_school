- Perfect number: sum of its factors (excluding itself) = number
- Abundand number: sum of its factors > number
- Deficient number: sum of its factors < number
  - Includes all prime numbers

Problem: find which of the 3 clasifications a number belongs to

Algorithm:
- Create a factors variable and bind to empty array
- Iterate from num to num/2
  - If the number % current number == 0, place in factors
- Add factors and return classification as string
  - Use case statement?