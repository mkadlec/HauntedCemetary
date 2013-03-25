# story array[page number, option 1 page number, option 2 page number] 
story = [[0, 1, 1], [1, 2, 3], [2, 4, 3], [3, 5, 6], [4, 9, 3], [5, 12, 6], [6, 7, 8], [7, 99, 99], [8, 99, 99], [9, 1, 10],
		 [10, 11, 99], [11, 1, 1], [12, 13, 1]]
# starting health
@health = 10

def instructions()

	puts ""
	puts "Welcome to the game of".center(80)

	puts ""
	puts "Haunted Cemetary".center(80)

	puts "\nTo get started, type your name."

	@name = gets.chomp.capitalize

end

def fight(opponent, opponent_health)
	keep_fighting = true 

	while keep_fighting
		puts "\nYour health is " + @health.to_s 
		puts opponent + "'s health is " + opponent_health.to_s
		puts "\nDo you,"
		puts "1. Fight the " + opponent
		puts "2. Run away"

		get_choice()
		if @choice == 1
			your_roll = rand(6) + 1
			opponent_roll = rand(6) + 1
			puts "\n\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			puts "You rolled " + your_roll.to_s + ", and " + opponent + " rolled " + opponent_roll.to_s
			if (your_roll == opponent_roll)
				puts "You both miss each other"
			elsif (your_roll > opponent_roll) 
				loss = your_roll - opponent_roll
				opponent_health -= loss
				puts opponent + " loses " + loss.to_s
			else
				loss = opponent_roll - your_roll
				@health -= loss
				puts "You lose " + loss.to_s + " health."
			end

			if @health <= 0
				"\nYou died!"
				return :you_lost_the_fight
			elsif opponent_health <= 0
				"You beat the " + opponent + "!"
				return :you_won_the_fight
			end
		elsif @choice == 2
			"\nYou ran away!"
			return :you_ran_away
		else
			keep_fighting = false
		end
	end


end

def get_choice()
	@choice = 0
	while (@choice < 1 || @choice > 2)
		@choice = gets.chomp.to_i

		if @choice >= 1 && @choice <= 2
			@choice = @choice.to_i
			return
		end

		puts "\nNot a valid choice, please try again."
	end
end

def go_to(page)
	puts "\n\n\n"
	case page
	when 1
		puts "Hi " + @name + ", you are in a dark cemetary and you hear a noise in an old shed.  Do you,"
		puts "1. Go into the shed"
		puts "2. Keep walking"
	when 2
		puts "You enter the shed and it is too dark to see.  There is a light switch, but you hear a growl in the corner.  Do you,"
		puts "1. Turn on the light"
		puts "2. Run out of the shed"	
	when 3
		puts "After walking a while you see a deep hole that looks like a tunnel, do you,"
		puts "1. Climb into the hole"
		puts "2. Keep walking"	
	when 4
		puts "You turn on the light and see a man that is tied up!  Do you,"
		puts "1. Untie him"
		puts "2. Keep walking"	
	when 5
		puts "You climb in to the hole and turn on your flash light.  After a while you see a door, but the tunnel keeps going.  Do you,"
		puts "1. Go into the door"
		puts "2. Keep walking"	
	when 6
		puts "You are walking and suddenly fall into a deep pit filled with water!  A shark is swimming to you.  Do you,"
		puts "1. Punch the shark in the eye and swim to shore"
		puts "2. Try and grab your gun and shoot him"	
	when 7
		puts "You punch the shark and it seems to slow him down."
		puts "You swim as fast as you can and reach the shore!"
		puts "There is a treasure chest filled with gold, you are rich!"
		return :game_over
	when 8
		puts "Your gun does not work in water and before you can shoot the shark attacks you!"
		puts "No one can find you in this shark tank, game over."
		return :game_over
	when 9
		puts "The man thanks you and tells you he knows where a treasure is.  He pulls out a map."
		puts "Suddenly a zombie is at the front door!  Do you,"
		puts "1. Grab the map from the man and run out the back door"
		puts "2. Stay with the man and fight the zombie"	
	when 10
		result = fight("Zombie", 6)

		if result == :you_won_the_fight
			@health += 2
		end

		return result
	when 11
		puts "You beat the zombie!  You and the man run out the door and find yourself in front of a dark brick house.  Do you,"
		puts "1. Leave the man and go in the house"
		puts "2. Follow the man with the map and find the treasure"	
	when 12
		puts "You walk through the door and see a mummy walking towards you!  You have no time to run so you have to fight the mummy."
		result = fight("Mummy", 7)

		if result == :you_won_the_fight
			@health += 3
		end

		return result
	when 13
		puts "\nYou beat the mummy!  You leave the room and run out of the door and start walking down the hall."
		@page = 6
		@choice = 0
		return :skip_question
	end

end

def the_end
	sleep 3
	puts "The End."
	puts "\nWant to start again?"
	puts "1. Yes\n"
	puts "2. No"	
	get_choice()
	if @choice == 1
		@page = 0
		@choice = 1
		@retval = :restart
	else
		puts "\nThanks for playing " + @name + "!"
	end
end

#
#  Game logic
#

instructions()

@page = 0
@choice = 1
@retval = :game_on

while @retval != :game_over
	#puts "Page:" + @page.to_s + " Choice:" + @choice.to_s
	@page = story[@page][@choice]
	@retval = go_to(@page)

	if @retval == :you_won_the_fight
		@choice = 1
	elsif @retval == :you_lost_the_fight
		puts "\nOh no! You wake up and are at the start again...\n"
		@health = 10
		@page = 0
		@choice = 1
	elsif @retval == :you_ran_away
		puts "\nYou run away, heal, and are ready to fight again!\n"
		@choice = 0
		@health = 8
	elsif @retval == :skip_question
		#do nothing
	else
		if @retval != :game_over
			get_choice()
		else
			the_end()
		end		
	end
end

	









