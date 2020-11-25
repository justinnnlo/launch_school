Problem: count the number of occurances of each word, ignoring punctuation

Input: string
Output: hash

Algortihm
- Create hash with default of 0 and bind to result variable
- Split the string by:
  - Spaces
- Iterate through each word and clean string from
  - Punctuation: !, &, @, $, %, ^, :, ",", ";", -
    - Note: except apostrophes (')
  - Newlines: \n
- Iterate through the resulting array, with words in downcase, and have each word be a key
  - Increase each value by 1 for each occurance
- Return the hash
