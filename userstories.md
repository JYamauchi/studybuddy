Study Buddy user stories

As a new user, when I type "new," I should be prompted to add my name and be redirected to the main menu

As an existing user, when I type my name, I should be redirected to "my" main menu

As a signed-in user, when I type "view," I should see a list of all existing decks from all users

* When I type "cards," I should be prompted to choose a deck by its ID number
 *When I type in a deck ID, all of that deck's question cards should be listed, and I should be redirected back to the main menu to see all my options again. The program should wait for my next input.
* When I type "leaderboards," I should be prompted to choose a deck by its ID number
 *When I type in a deck ID, I should see a list of scores for that deck, ranked by highest score to lowest
* When I type "back," I should be redirected again to the main menu

As a signed-in user, when I type "history," I should see a list of games I have played recently and how I scored on each one.

As a signed-in user, when I type "add," I should be prompted to give the new deck a name
* Once I have entered a name, I should be prompted to give a description of the cards inside the deck
* Once I have entered a description, I should see a confirmation that the deck is saved, and a suggestion that I type "edit" to start adding cards

As a signed-in user, when I type "edit," I should see a list of decks, but ONLY the decks I have created myself. I should be prompted to choose a deck by entering its ID number.
* When I enter a deck ID, I should see the list of its question cards, and see options to add a card, update an existing card, delete a card, or go back to the main menu
 * When I type "add," I should be prompted to enter the q-side of the new card
  * When I enter the q-side, I should be prompted to enter the a-side of the new card
  * When I enter the a-side, I should be prompted to either add another card or go back to the menu ("nah")
 * When I type "update," I should see the list of question cards again, and be prompted to enter the q-side I would like to edit.
  * When I enter the q-side, I should be prompted to specify whether I'd like to update the question, answer, or both for the card
  * For Q, I should be prompted to enter the new Q; for A, the new A; for both, both
 * When I type "delete," I should see the list of question cards again, and be prompted to enter the q-side I would like to delete.

As a signed-in user, when I type "delete," I should see a list of decks, but ONLY the decks I have created myself. I should be prompted to choose a deck by entering its ID number. 
* When I enter a deck ID, I should see a confirmation ("Like it never existed...") and be redirected to the main menu.

As a signed-in user, when I type "play," I should see a list of all decks created by all users. I should be prompted to choose a deck by entering its ID number.
* When I enter a deck ID, the program should indicate that the game has started and print the description/instructions for the deck. It should also note that the user can pause. It should print the first Q-side card.
 * When I enter the correct A-side for that card, the program should print "Correct!" and move on to the next question.
 * when I enter a wrong input, the program should print "Whoops..." and move on to the next question.
 * When I enter "pause," the program should say "Game paused!" and note that I can resume the game from the main menu.
 * When I iterate through all the cards without pausing, the program should print a different message if I get a perfect score, if I get none right, and if I have a mix of correct and incorrect answers ("You got x right and only missed y")

As a signed-in user, when I type "resume," the program should print one of two things:
* If I don't have any games paused in progress, it should tell me so
* If I do have games paused, it should list those games and prompt me to enter the ID of the game I want to resume
 * If I enter a game ID, the program should skip the questions I have already answered and ask the next question in the sequence. The game should end as described above.

As a signed-in user, when I type "switch," the program should show the list of existing users and also the option to create a new user.

As a signed-in user, when I type "quit," the program should urge me to take a study break, and then the program should end.



