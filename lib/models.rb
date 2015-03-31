require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :host	=> "localhost",
  :database => "studybuddy"
)

class CreateTables < ActiveRecord::Migration

	def initialize
		create_table :decks do |column|
			column.string :name
			column.string :description
		end

		create_table :cards do |column|
			column.belongs_to :deck
			column.string :q
			column.string :a
		end

	end
end

class Deck < ActiveRecord::Base
	has_many :cards

	def initialize(name = nil, cards = nil)
		@name = name
		@cards = cards
	end

	def self.list_decks
		puts("Listing all decks:")
		Deck.all.each do |deck|
			puts("Name: #{deck.name}")
			puts("Description: #{deck.description}")
			puts("------")
		end
	end

	def list_cards
		if @cards.empty?
			puts("This deck is empty. Add some cards!")
		else
			puts("Listing Q-side cards for this deck:")
			@cards.each do |card|
				puts("#{card.q}")
			end
		end
	end

	def add_card(q = nil, a = nil)
		puts("Enter the Q-side or 'question' for this card.")
		q = gets().chomp()
		puts("Enter the A-side or 'answer' for this card.")
		a = gets().chomp()
		@cards << Card.new(q: q, a: a)
	end

	def remove_card(q = nil)
		if q == nil
			puts("Which card do you want to remove?")
			name = gets().chomp().downcase()
		end
		index = 0
		num_cards = @cards.count
		while index < num_cards
			if @cards[index].name == name
				@cards.delete_at(index)
			end
			index = index + 1
		end
		if num_cards == @cards.count
			puts("I don't have a card like that in this deck.")
		end
	end

	def play
		if @cards.count > 0
			###game is played
		else
			puts("This deck is empty! Add some cards to play.")
		end
	end

	def game
		@cards.shuffle
		@cards.each do |card|
			puts("Q: #{card.q}")
			user_a = gets().chomp().downcase
			if user_a == card.a.downcase
				#answer is recorded as correct
				puts("Right!")
			else
				#answer is recorded as incorrect
				puts("Wrong!")
			end
		end
	end


end

class Card < ActiveRecord::Base
	belongs_to :deck

end

binding.pry
