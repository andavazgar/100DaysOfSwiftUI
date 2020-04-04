# Project 5: *WordScramble*

The game shows a random eight-letter word. The goal is to write as many words as possible only using the letters from the starter word. For example, if the starter word is “alarming” they might spell “alarm”, “ring”, “main”, and so on.


## Topics

Views: `List`  
Modifiers: `onAppear()`  
`Bundle`, `fatalError()`, `UITextChecker`

## Challenges

> 1. Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into `isReal()` that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.
> 
> 2. Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.
> 
> 3. Put a text view below the List so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.


## Screenshots

![Screenshots](Screenshots/Combined.png)