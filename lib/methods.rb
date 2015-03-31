require_relative 'models'
require 'pry'

	def list_decks
		puts("Listing all decks:")
		Deck.all.each do |deck|
			puts("------")
			puts("ID: #{deck.id}")
			puts("Name: #{deck.name}")
			puts("Description: #{deck.description}")
			puts("------")
		end
	end

	def get_deck
		list_decks
		puts("Which deck? Enter its ID number.")
		deck_id = gets().chomp().to_i()
		return Deck.find(deck_id)
	end

	binding.pry

	def list_cards
		if .empty?
			puts("This deck is empty. Add some cards!")
		else
			puts("Listing Q-side cards for this deck:")
			@cards.each do |card|
				puts("#{card.q}")
			end
		end
	end

	# def add_card(q = nil, a = nil)
	# 	puts("Enter the Q-side or 'question' for this card.")
	# 	q = gets().chomp()
	# 	puts("Enter the A-side or 'answer' for this card.")
	# 	a = gets().chomp()
	# 	@cards << Card.new(q: q, a: a)
	# end

	# def remove_card(q = nil)
	# 	if q == nil
	# 		puts("Which card do you want to remove?")
	# 		name = gets().chomp().downcase()
	# 	end
	# 	index = 0
	# 	num_cards = @cards.count
	# 	while index < num_cards
	# 		if @cards[index].name == name
	# 			@cards.delete_at(index)
	# 		end
	# 		index = index + 1
	# 	end
	# 	if num_cards == @cards.count
	# 		puts("I don't have a card like that in this deck.")
	# 	end
	# end

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