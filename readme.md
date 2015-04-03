```
   _____ __            __      ____            __    __     
  / ___// /___  ______/ /_  __/ __ )__  ______/ /___/ /_  __
  \__ \/ __/ / / / __  / / / / __  / / / / __  / __  / / / /
 ___/ / /_/ /_/ / /_/ / /_/ / /_/ / /_/ / /_/ / /_/ / /_/ / 
/____/\__/\__,_/\__,_/\__, /_____/\__,_/\__,_/\__,_/\__, /  
                     /____/                        /____/                                              
```

StudyBuddy is a flash card sharing and organization system. Users can:

	-create decks of flash cards
	-share decks with other users and browse other users' decks
	-edit or delete only decks that they themselves created
	-compete with other users on leaderboards
	-view their personal 'recently played games' history
	-pause and resume games

## Instructions

	-Navigate to /studybuddy/lib/ in the Terminal
	-Run $ ruby studybuddy.rb
	-Sign in as an existing user by typing one of the listed names, or type "new" to add a new user
	-In the main menu, browse existing decks by typing "view"
		-From the deck list, type "cards" to see the individual question cards within each deck
		-Type "leaderboards" to see the list of users who have played each deck, ranked from highest-scoring to lowest
	-Typing "history" will show the list of games you've played recently and how you scored on them
	-Typing "edit" will allow you to make changes to cards within decks you've created (you can't alter decks created by other users)
	-Typing "delete" will allow you to delete decks you've created (same limitation applies!)
	-Typing "play" brings up the list of decks and allows you to start a game
	-Typing "resume" will bring up a list of games you've paused midway and allow you to continue playing them
	-Typing "switch" brings back the list of users and allows someone else to sign in
	-Typing "quit" ends the program.


## User Stories and Project Tasks
	
	-For a list of user stories describing the program's behavior, please see the 'userstories.txt' file.
	-For a look at how I divided up the pieces of the program, here's my Trello board: https://trello.com/b/rsQsfbyg/julia-s-flash-cards
		-You'll notice there are a few features I didn't have time to implement. Maybe someday...

	
## Testing

	-RSpec tests are included in the 'studybuddy_spec.rb' file within the directory /studybuddy/spec/
	-To run these, navigate to the main /studybuddy/ directory in the Terminal and run $ rspec


## ERD
	
	-The ERD for this program is included as an image, erd.jpg



