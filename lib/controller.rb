require_relative "models.rb"
require_relative "title.rb"

class Run

	def initialize
		title
		program_puts("Welcome! Sign in as an existing user or create a new user:")
		choose_user
	end

	def menu
			while true 
				puts("")
				program_puts("#{@user.name}'s StudyBuddy Menu")
			    program_puts("---")
			    program_puts("(View) all decks from all users")
			    program_puts("(History)")
			    program_puts("(Add) a new deck")
			    program_puts("(Edit) a deck")
				program_puts("(Delete) a deck")
				program_puts("(Play) a deck")
				program_puts("(Resume) a game")
				program_puts("(Switch) users")
				program_puts("(Quit)")

				case gets().chomp().to_s().downcase()
					when "view"
					list_decks
					program_puts("(Cards) to view a deck's cards, (Leaderboards) for game stats, or (Back) to the main menu")
					input = gets().chomp().to_s().downcase()
						case input
							when "cards"
								@deck = get_deck
								@deck.list_cards
							when "leaderboards"
								@deck = get_deck
								@deck.leaderboard
							when "back"
								menu
							else
								program_puts("Whatchu talkin' bout?")
						end

					when "history"
						@user.history
						
					when "add"
				  		@user.add_deck

					when "edit"
						@user.list_my_decks
						@user.edit_deck

					when "delete"
						@user.list_my_decks
						@deck = get_deck
						@deck.delete
						program_puts("Like it never existed...")
						
					when "play"
						list_decks
						@deck = get_deck
						@deck.play(@user.id)

					when "resume"
						@user.resume_game

					when "switch"
						choose_user

					when "quit"
						abort("\033[32mThat's right, go take a study break.\033[0m\n".indent(4))
					
					else
						program_puts("I am not picking up what you're putting down.")
			    end
			end
		end

end

