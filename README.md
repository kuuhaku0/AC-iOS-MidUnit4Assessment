# AC-iOS Midprogram iOS Asessment

## Setup

1. Fork this repo.
1. Clone this repo to your laptop.
1. Work on the assessment as described below.
1. Commit your work.
1. Push it to your fork.
1. Create a pull request.
1. Submit your project to Canvas

## Objective

Build an app that plays a game with drawing cards.  The goal of the game is to get as close to 30 as possible without going over.  If the player gets 30, they win.  If they go over 30, they lose.  The player can chose to stop before they get to the 30 and end the game early so they don't go over.


## Organization

Your app should have a Tab Bar Controller that manages two View Controllers, a View Controller for playing the game, and another View Controller for viewing past games.

**Your Game View Controller should have:**

- A collection view to store the cards (both their image and their value in the game)
- A label displaying the current value of their hand
- A label with the instructions
- A button to draw a card
- A button to stop drawing cards and end the game

**Your History View Controller should have:**

- A table view that displays all the previous hands
- A button that resets the stored games

**Your History View Controller's Table View should have:**

- A collection view to store the cards (both their image and their value in the game)
- A label displaying the current value of their hand

For full credit:

- You must use a .xib file for your collection view cell.
- Your persistance should happen using the File Manager


## Game Rules

- Pressing "Draw a Card" should draw a card from the deck into your hand.
- The values of cards are as follows

| Card Name | Card Value |
|---|---|
| Two | 2 |
| Three | 3 |
| Four | 4 |
| Five | 5 |
| Six | 6 |
| Seven | 7 |
| Eight | 8 |
| Nine | 9 |
| Ten | 10 |
| Jack | 10 |
| Queen | 10 |
| King | 10 |
| Ace | 11 |

- After the player draws a card, the game should add it to their current hand value
- If their current hand value is 30, display a victory message
- If their current hand value is greater than 30, display a defeat message
- If their current hand value is less than 30, they can either chose to end the game, or draw more cards.  If they end the game, display a message showing how far they were away from 30.  Otherwise, they can continue drawing more cards until they win by hitting 30, lose by going over 30 or chose to stop drawing cards.

## Endpoints

You do not need to manage the deck of cards yourself.  Use the [deck of cards API](https://deckofcardsapi.com/) to facilitate drawing cards:

There are two endpoints you will need:


**Get a new deck of cards**

```
https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=6
```

**Draw one card from your deck**

```
https://deckofcardsapi.com/api/deck/<<deck_id>>/draw/?count=1
```

**Cards have an image which can be found in their "image" property**

```
(example)
https://deckofcardsapi.com/static/img/KH.png
```


# Rubric

Criteria | Points
:---|:---
App uses AutoLayout correctly for all iPhones in portrait | 8 Points
Variable Naming and Readability | 4 Points
App uses MVC Design Patterns | 4 Points
Images are loaded without flickering | 4
Collection view cells are implemented using a .xib file | 4 points
Collection views display cards appropriately | 4 points
Can draw cards from the card API | 4
Game logic works appropriately | 4 points
Persists to File Manager with reset button | 4 points



Collection Views 


Elements model is built correctly and handles nils appropriately | 4 points
Elements are loaded into the tableview using a custom table view cell | 4 points
Thumbnail images are loaded into the tableview without flickering | 4 points
Detail view controller loads the element in correctly | 4 points
Detail view controller loads the large image appropriately | 4 points
Detail view controller button makes a Post request to Fieldbook | 4 points


A total of 40 points, with 2 points extra credit.
