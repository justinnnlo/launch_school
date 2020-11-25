Input: string
Output: Array of str elements

Problem: Given a word and a list of possible anagrams, return an array that contains the anagrams of the word present in the given list

Algorithm
- Create anagrams local variable and bind to empty array
- Create a hash: key is character and value is count
- Iterate through the array
  - If a word creates a hash that's equivalent to the given word, add it to the array
- Return the array