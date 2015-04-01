require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :host	=> "localhost",
  :database => "studybuddy"
)

class CreateTables < ActiveRecord::Migration

	def initialize
		create_table :users do |column|
			column.string :name
		end

		create_table :decks do |column|
			column.belongs_to :user
			column.string :name
			column.string :description
		end

		create_table :cards do |column|
			column.belongs_to :deck
			column.string :q
			column.string :a
		end

		create_table :games do |column|
			column.belongs_to :user
			column.belongs_to :deck
			column.integer :total_correct
			column.integer :missed, array: true, default: []
			column.datetime :timestamp, default: Time.now
		end

	end
end

class User < ActiveRecord::Base
	has_many :decks
	has_many :games

end

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

def get_user
	puts("Who's playing?")
	name = gets().chomp()
	User.find_by(name: name)
end

class Deck < ActiveRecord::Base
	has_many :cards
	has_many :games
	belongs_to :user

	def to_s
		return name
	end

	def list_cards
		if cards.empty?
			puts("This deck is empty. Add some cards!")
		else
			puts("Listing Q-side cards for this deck:")
			cards.each do |card|
				puts("-#{card.q}")
			end
		end
	end

	def add_card(q = nil, a = nil)
		if q == nil
			puts("Enter the Q-side or 'question' for this card.")
			q = gets().chomp()
		end
		if a == nil
			puts("Enter the A-side or 'answer' for this card.")
			a = gets().chomp()
		end
		cards << Card.new(q: q, a: a)
	end

	def get_card(q = nil)
		if q == nil
			list_cards
			puts("Enter the Q-side or 'question' of the card.")
			card = gets().chomp()
		end
		cards.find_by(q: card)
	end


	def remove_card(q = nil)
		get_card.delete
	end

	def update_card(q = nil)
		card = get_card
		puts("Update Q, A, or both?")
		input = gets().chomp().downcase

		if input == "q"
			puts("Enter the updated Q-side or 'question' for this card.")
			q = gets().chomp()
			card.update(q: q)
		elsif input == "a"
			puts("Enter the updated A-side or 'answer' for this card.")
			a = gets().chomp()
			card.update(a: a)
		elsif input == "both"
			puts("Enter the updated Q-side or 'question' for this card.")
			q = gets().chomp()
			puts("Enter the updated A-side or 'answer' for this card.")
			a = gets().chomp()
			card.update(q: q, a: a)
		else
			puts("I wasn't sure what you wanted to edit.")
		end
	end

	def play
		user_id = get_user.id
		deck_id = id
		@g = Game.new(user_id: user_id, deck_id: deck_id, total_correct: 0)
		puts("-----GAME START-----")
		puts(description)
		iterate
		puts("-----GAME OVER-----")
		@g.update(timestamp: Time.now)
		@g.save
		@g.summarize
	end

	def iterate
		cards.each do |card|
			puts("#{card.q}")
			input = gets().chomp().downcase

			if input == card.a.downcase
				puts("Correct!")
				@g.total_correct = @g.total_correct + 1
			else
				puts("Whoops...")
				@g.missed << card.id
			end
		end
	end

end

class Card < ActiveRecord::Base
	belongs_to :deck

	def to_s
		return q
	end
end

class Game < ActiveRecord::Base
	belongs_to :deck
	belongs_to :user

	def summarize
		if missed.count == 0
			puts("Congratulations! You know these cards perfectly!")
		elsif total_correct == 0
			puts("Well, you didn't get any of these, but that's why we're studying!")
		else
			puts("All done! You got #{total_correct} cards correct and only missed #{missed.count}.")
		end
	end

end

binding.pry
