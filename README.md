#Scrabbble

_"Where the Q's and Z's are worth 9"_

###User Stories
1.	General:
	a. As a Player, I want to be able to...
		1. Create an account to play the game
		2. Login into an existing account
		3. Create a game to play
		4. Join an existing game needing another player
		5. See how many games I have won or lost
2. Game Play:
	a. As a current player, I want to be able to... 
		1. Move a tile from my tray and place on the board.
		2. Move a tile from the board back to my tray.
		3. Not be able to place a tile in a invalid spot on the board (existing letter / not on board)
		4. Reset my tray and return all letters to my tray with a click of button.
		5. Shuffle my tiles on my tray with a click of a button.
		6. Switch out any number of tiles in my tray with random tiles in bag
		7. Start a game by placing a tile in the center cell
		8. Place a word on the board and push a submit button
		9. Be informed if the word I submitted is valid or not.
		10. Get and updated score and complete my turn on a valid word submission.
		11. Get new letters placed in my tray at end of turn.
		12. Be told of an invalid word(s) and allowed to play a different word.
		13. Play multiple games at once / switch between active games
		14. Forfeit a game I don't want to play anymore
	b. As a non-current player, I want to be able to...
		1. Have my brower automatically update to inform me of my turn
		2. Be able to refresh my page manually to show updated board
		3. Shuffle my tray or rearrange my tiles during my off-turn
		4. Disallow me from placing a tile or pushing submit when it is not my turn			

---

#####Schema
![resize icon][2]

[2]: http://i.imgur.com/kEwF7C0.png

#####Hip Chat Info
https://www.hipchat.com/invite/113393/d0f3b853c9eac4a44c9ad2dbda4891ff

***

###To Do List
1. Ruby
	a. Models
		1. 
	b. Controllers
		1. Refactor
		2. AJAX request actions
	c. Views
		1. Modify (0..14) to be constants on show view
	d. Other
		1. Update REST routes
2. JS
	a. Game Logic
		1. Determine if placed word is valid
		2. Locate all other words associated with placed word
		3. Send all words to Serve using AJAX
3. Testing
	a. Models
		a. user-defined models
	b. Controllers
		a. confirm actions have 200 messages
	c. Views
		a. capaybara tests
	d. JS
		a. Jasmine testing?
4. AJAX
	a. Check Words
		1. Send words (JS --> Ruby)
		2. Check words, send response (Ruby --> JS)
		3. Prompt user, send additional data if necessary (JS --> Ruby)
			a. x, y, tile points, cell points?
	b. New Tiles
		1. Give player new tiles at end of turn
5. Multiple Screens/Ports
	a. ??	