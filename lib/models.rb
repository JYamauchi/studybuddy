require 'active_record'
require_relative 'controller.rb'
require_relative 'methods.rb'
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
			column.integer :paused_at, default: nil
			column.datetime :timestamp, default: Time.now
		end

	end
end

class User < ActiveRecord::Base
	has_many :decks, dependent: :destroy
	has_many :games, dependent: :destroy

	def add_deck
	program_puts("Give your deck a name:")
	name = gets().chomp()
	program_puts("Now give some instructions or a brief description of the cards inside:")
	description = gets().chomp()
	@deck = self.decks.create(name: name, description: description)
	program_puts("New deck saved! Now maybe (edit) it to add some cards?")
	program_puts("***")
	end

	def edit_deck
	@deck = get_deck
	if @deck == nil
		return
	else
		@deck.list_cards
		program_puts("(Add) a new card, (Update) an existing card, or (Delete) a card")
		program_puts("Or (Back) to the main menu")
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
					program_puts("I don't know what you're trying to tell me!")
			end
		end
	end

	def list_my_decks
		if self.decks.count == 0
			program_puts("You haven't made any decks yet!")
		else
			program_puts("Listing all your decks:")
			puts("")
			self.decks.each do |deck|
				program_puts("ID: #{deck.id} // Created by: #{User.find(deck.user_id).name}")
				program_puts("Name: #{deck.name}")
				program_puts("Description: #{deck.description}")
				program_puts("---")
			end
		end
	end

	def resume_game
		program_puts("#{name}'s Games In Progress")
		program_puts("---")
		games.each do |game|
			if game.paused_at != nil
				program_puts("(ID: #{game.id}) #{game.timestamp} // Deck: #{game.deck.name} // Correct answers so far: #{game.total_correct} // Incorrect answers so far: #{game.missed.count}")
				@paused_game_exists = "yes"
			end
		end

		if @paused_game_exists != "yes"
			program_puts("Psych!!! You don't have any games in progress!")
		else
			program_puts("Which game? Type its ID to resume.")
			input = gets().chomp().to_i()
			@game = Game.find(input)
			start_again(@game)
		end
	end

	def start_again(game)
		@game = game
		@deck = Deck.find(@game.deck_id)
		start_index = @game.paused_at 
		catch (:done)  do
			@deck.cards.each_with_index do |card, index|
				if index < start_index 
					puts("Skipping...")
				elsif index >= start_index
					program_puts("#{card.q}")
					input = gets().chomp().to_s().downcase()

					if input == card.a.downcase
						program_puts("Correct!")
						@game.total_correct = @game.total_correct + 1
					elsif input == "pause"
						@game.paused_at = index
						@game.save
						program_puts("Game paused! To resume, visit (resume) on the main menu.")
						throw :done
					else
						program_puts("Whoops...")
						@game.missed << card.id
					end
				end
			end
			@deck.end_game(@game)
		end
	end

	def history
		program_puts("#{name}'s Recent Games")
		program_puts("---")

		if games.count == 0
			program_puts("Your history is empty because you haven't played any games yet!")
		else
			games.each do |game|
				program_puts(">> #{game.timestamp} // Deck: #{Deck.find(game.deck_id).name} // Correct answers: #{game.total_correct} // Incorrect answers: #{game.missed.count}")
			end
		end
	end

end

class Deck < ActiveRecord::Base
	has_many :cards, dependent: :destroy
	has_many :games, dependent: :destroy
	belongs_to :user
	validates :name, presence: true

	def list_cards
		if cards.empty?
			program_puts("This deck is empty!")
			program_puts("***")
		else
			program_puts("Deck: #{self.name}")
			program_puts("Listing Q-side cards for this deck:")
			puts("")
			cards.each do |card|
				puts("-#{card.q}".indent(8))
			end
			program_puts("***")
		end
	end

	def add_card(q = nil, a = nil)
		if q == nil
			program_puts("Enter the Q-side or 'question' for this card.")
			q = gets().chomp().to_s()
		end
		if a == nil
			program_puts("Enter the A-side or 'answer' for this card.")
			a = gets().chomp().to_s()
		end
		cards << Card.new(q: q, a: a)

		program_puts("(Add) another card? Or (nah)")
		input = gets().chomp().downcase()
		if input == "add"
			add_card
		else
			program_puts("Ok cool.")
		end
	end

	def get_card(q = nil)
		if q == nil
			list_cards
			program_puts("Enter the Q-side or 'question' of the card.")
			card = gets().chomp().to_s()
		end
		cards.find_by(q: card)
	end


	def remove_card(q = nil)
		get_card.delete
	end

	def update_card(q = nil)
		if self.cards.count == 0
			program_puts("You can't update a card that doesn't exist yet!")
		else
			card = get_card
			program_puts("Update Q, A, or both?")
			input = gets().chomp().downcase

			if input == "q"
				program_puts("Enter the updated Q-side or 'question' for this card.")
				q = gets().chomp().to_s()
				card.update(q: q)
			elsif input == "a"
				program_puts("Enter the updated A-side or 'answer' for this card.")
				a = gets().chomp().to_s()
				card.update(a: a)
			elsif input == "both"
				program_puts("Enter the updated Q-side or 'question' for this card.")
				q = gets().chomp().to_s()
				program_puts("Enter the updated A-side or 'answer' for this card.")
				a = gets().chomp().to_s()
				card.update(q: q, a: a)
			else
				program_puts("I wasn't sure what you wanted to edit.")
			end
		end
	end

	def play(user_id)
		@game = Game.new(user_id: user_id, deck_id: id, total_correct: 0)
		program_puts("-----GAME START-----")
		program_puts(description)
		program_puts("(Pause) at any time; your progress will be saved.")
		iterate
	end

	def iterate
		catch (:done)  do
			cards.each_with_index do |card, index|
				program_puts("#{card.q}")
				input = gets().chomp().to_s().downcase()
				if input == card.a.downcase
					program_puts("Correct!")
					@game.total_correct = @game.total_correct + 1
				elsif input == "pause"
					@game.paused_at = index
					@game.save
					program_puts("Game paused! To resume, visit (resume) on the main menu.")
					throw :done
				else
					program_puts("Whoops...")
					@game.missed << card.id
				end
			end

			if @game.total_correct + @game.missed.count == cards.count
				end_game(@game)
			end
		end
	end

	def end_game(game)
		@game = game
		program_puts("-----GAME OVER-----")
		@game.update(timestamp: Time.now)
		@game.update(paused_at: nil)
		@game.save
		@game.summarize
	end

	def leaderboard
		program_puts("#{name} Leaderboard:")
		games.order(total_correct: :desc).each do |game|
			program_puts("#{User.find(game.user_id).name} got #{game.total_correct} correct answers on #{game.timestamp}!")
		end
	end

end

class Card < ActiveRecord::Base
	belongs_to :deck
	validates :deck, presence: true

end

class Game < ActiveRecord::Base
	belongs_to :deck
	belongs_to :user
	validates :user, presence: true
	validates :deck, presence: true

	def summarize
		if missed.count == 0
			program_puts("Congratulations! You know these cards perfectly!")
			program_puts("***")
		elsif total_correct == 0
			program_puts("Well, you didn't get any of these, but that's why we're studying!")
			program_puts("***")
		else
			program_puts("All done! You got #{total_correct} cards correct and only missed #{missed.count}.")
			program_puts("***")
		end
	end

end

# binding.pry
