#StudyBuddy misc methods that don't belong to a Class	

	def program_puts(string)
		puts("\033[32m#{string.indent(4)}\033[0m\n")
	end

	def list_decks
		program_puts("Listing all decks:")
		program_puts("***")
		Deck.all.each do |deck|
			program_puts("ID: #{deck.id} // Created by: #{User.find(deck.user_id).name}")
			program_puts("Name: #{deck.name}")
			program_puts("Description: #{deck.description}")
			program_puts("------")
		end
	end

	def get_deck
		program_puts("Which deck? Enter its ID number.")
		deck_id = gets().chomp().to_i()
		return Deck.find(deck_id)
	end


	def list_users
		User.all.each do |user|
			program_puts(">> #{user.name}")
		end
	end

	def search_users(input) 
		User.all.each do |user|
			if user.name.downcase == input
				@user = user
			end
		end
		if @user != nil
			return true
		else
			return false
		end
	end


	def choose_user
		list_users
	    program_puts(">> (New)")
	    input = gets().chomp().to_s().downcase
	    if input == "new" 
	    	add_user
	    	puts("")
	    	program_puts("OK #{@user.name}, let's get started.")
	    	menu
	    elsif search_users(input) == true
	    	program_puts("Hey again #{@user.name}! You ready to study?")
	    	menu
	    else
			program_puts("Bruh, I don't understand. Bruh! Pick one of these:")
			choose_user
	    end
	end

	def add_user
		program_puts("Hey n00b! What's your name?")
		name = gets().chomp().to_s()
		@user = User.create(name: name)
	end



