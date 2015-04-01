require_relative "models.rb"
require_relative "title.rb"

class Run

  def initialize
    title
    puts("Welcome! Choose an option below:")
    menu
  end

  def menu
    while true
      puts("(View) all decks".indent(4))
      puts("(Add) a new deck".indent(4))
      puts("(Edit) a deck".indent(4))
      puts("(Delete) a deck".indent(4)) 
      puts("(Play) a deck".indent(4))
      puts("(Quit)".indent(4))
      case gets().chomp().to_s().downcase()
	      when "view"
	      	list_decks
			puts("(Edit) to view a deck's cards, or (Back) to the main menu".indent(4))
			input = gets().chomp().to_s().downcase()
			case input
				when "edit"
					edit_deck
				when "back"
					menu
				else
					puts("Whatchu talkin' bout?".indent(4))
			end
	      when "add"
	      	add_deck

	      when "edit"
	      	list_decks
			edit_deck

	      when "delete"
	      	list_decks
	      	@deck = get_deck
			@deck.delete
	      when "play"
	      	list_decks
	      	@deck = get_deck
			@deck.play
	      when "quit"
			puts("That's right, go take a study break.".indent(4))
			return
	      else
			puts("That's not a valid input.".indent(4))
      end
    end
  end

end
