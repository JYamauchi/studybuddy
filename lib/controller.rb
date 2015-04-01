require_relative "models.rb"

class Run

  def initialize
    puts "Welcome to StudyBuddy!"
    menu
  end

  def menu
    while true
      puts "(View) all decks, (Add) a card to a deck, (Remove) a card, (Play) a deck, (Quit)"
      case gets.chomp.to_s.downcase
      when "view"
		list_decks
      when "add"
		
      when "remove"
	@arena.remove_gladiator
      when "play"
	@arena.fight
      when "quit"
	puts "You leave the arena, and it vanishes into thin-air because this program doesn't have data persistence."
	break
      else
	puts "That's not a valid input."
      end
    end
  end

end
