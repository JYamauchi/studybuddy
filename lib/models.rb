require 'active_record'
require_relative '../indent_string.rb'
# require 'pry'

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

def add_deck
	puts("Give your deck a name:".indent(4))
	name = gets().chomp()
	puts("Now give some instructions or a brief description of the cards inside:".indent(4))
	description = gets().chomp()
	@deck = Deck.create(name: name, description: description)
	puts("New deck saved! Now maybe (edit) it to add some cards?".indent(4))
	puts("***".indent(4))
end

def list_decks
	puts("Listing all decks:".indent(4))
	puts("***".indent(4))
	Deck.all.each do |deck|
		puts("ID: #{deck.id}".indent(4))
		puts("Name: #{deck.name}".indent(4))
		puts("Description: #{deck.description}".indent(4))
		puts("------".indent(4))
	end
end

def get_deck
	puts("Which deck? Enter its ID number.".indent(4))
	deck_id = gets().chomp().to_i()
	return Deck.find(deck_id)
end

def edit_deck
	@deck = get_deck
	@deck.list_cards
	puts("(Add) a new card, (Update) an existing card, or (Delete) a card".indent(4))
	puts("Or (Back) to the main menu".indent(4))
	input = gets().chomp().downcase()
	case input
		when "add"
			@deck.add_card
		when "update"
			@deck.update_card
		when "delete"
			@deck.remove_card
		when "back"
			
		else
			puts("I don't know what you're trying to tell me!".indent(4))
	end
end

def get_user
	puts("Who's playing?".indent(4))
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
			puts("This deck is empty. Add some cards!".indent(4))
			puts("***".indent(4))
		else
			puts("Listing Q-side cards for this deck:".indent(4))
			puts("")
			cards.each do |card|
				puts("-#{card.q}".indent(8))
			end
			puts("***".indent(4))
		end
	end

	def add_card(q = nil, a = nil)
		if q == nil
			puts("Enter the Q-side or 'question' for this card.".indent(4))
			q = gets().chomp()
		end
		if a == nil
			puts("Enter the A-side or 'answer' for this card.".indent(4))
			a = gets().chomp()
		end
		cards << Card.new(q: q, a: a)

		puts("(Add) another card? Or (nah)".indent(4))
		input = gets().chomp().downcase()
		if input == "add"
			add_card
		else
			puts("Ok cool")
		end
	end

	def get_card(q = nil)
		if q == nil
			list_cards
			puts("Enter the Q-side or 'question' of the card.".indent(4))
			card = gets().chomp()
		end
		cards.find_by(q: card)
	end


	def remove_card(q = nil)
		get_card.delete
	end

	def update_card(q = nil)
		card = get_card
		puts("Update Q, A, or both?".indent(4))
		input = gets().chomp().downcase

		if input == "q"
			puts("Enter the updated Q-side or 'question' for this card.".indent(4))
			q = gets().chomp()
			card.update(q: q)
		elsif input == "a"
			puts("Enter the updated A-side or 'answer' for this card.".indent(4))
			a = gets().chomp()
			card.update(a: a)
		elsif input == "both"
			puts("Enter the updated Q-side or 'question' for this card.".indent(4))
			q = gets().chomp()
			puts("Enter the updated A-side or 'answer' for this card.".indent(4))
			a = gets().chomp()
			card.update(q: q, a: a)
		else
			puts("I wasn't sure what you wanted to edit.".indent(4))
		end
	end

	def play
		user_id = get_user.id
		deck_id = id
		@g = Game.new(user_id: user_id, deck_id: deck_id, total_correct: 0)
		puts("-----GAME START-----".indent(4))
		puts(description)
		iterate
		puts("-----GAME OVER-----".indent(4))
		@g.update(timestamp: Time.now)
		@g.save
		@g.summarize
	end

	def iterate
		cards.each do |card|
			puts("#{card.q}".indent(4))
			input = gets().chomp().downcase

			if input == card.a.downcase
				puts("Correct!".indent(4))
				@g.total_correct = @g.total_correct + 1
			else
				puts("Whoops...".indent(4))
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
			puts("Congratulations! You know these cards perfectly!".indent(4))
			puts("***".indent(4))
			puts("")
		elsif total_correct == 0
			puts("Well, you didn't get any of these, but that's why we're studying!".indent(4))
			puts("***".indent(4))
			puts("")
		else
			puts("All done! You got #{total_correct} cards correct and only missed #{missed.count}.".indent(4))
			puts("***".indent(4))
			puts("")
		end
	end

end

# binding.pry
