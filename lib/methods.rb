# require_relative 'models'
# require 'pry'

# 	def list_decks
# 		puts("Listing all decks:")
# 		Deck.all.each do |deck|
# 			puts("------")
# 			puts("ID: #{deck.id}")
# 			puts("Name: #{deck.name}")
# 			puts("Description: #{deck.description}")
# 			puts("------")
# 		end
# 	end

# 	def get_deck
# 		list_decks
# 		puts("Which deck? Enter its ID number.")
# 		deck_id = gets().chomp().to_i()
# 		return Deck.find(deck_id)
# 	end

# 	binding.pry


	# def play
	# 	if @cards.count > 0
	# 		###game is played
	# 	else
	# 		puts("This deck is empty! Add some cards to play.")
	# 	end
	# end

	# def game
	# 	@cards.shuffle
	# 	@cards.each do |card|
	# 		puts("Q: #{card.q}")
	# 		user_a = gets().chomp().downcase
	# 		if user_a == card.a.downcase
	# 			#answer is recorded as correct
	# 			puts("Right!")
	# 		else
	# 			#answer is recorded as incorrect
	# 			puts("Wrong!")
	# 		end
	# 	end
	# end