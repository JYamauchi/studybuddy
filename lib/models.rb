require 'active_record'
# require 'pry'

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

	def to_s
		return name
	end
end

class Card < ActiveRecord::Base
	belongs_to :deck

	def to_s
		return q
	end
end

# binding.pry
