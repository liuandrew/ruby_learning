class MastermindBoard
    
    def initialize
        @turns = 0
        @correct_combination = []
        @previous_guesses = []
        @previous_responses = []
        12.times {@previous_guesses.push ["-", "-", "-", "-"]}
        12.times {@previous_responses.push [0, 0]}
        generate_numbers
        game_loop
    end
    
    private
    
    def generate_numbers
        4.times do 
            loop do
                number = rand(1..6)
                if @correct_combination.none?{|i| i == number}
                    @correct_combination.push(number)
                    break
                end
            end
        end
        end
    end
    
    def game_loop
        loop do
            puts "\n Turn #{@turns}"
            guess = prompt_guess
            response = test_guess(guess)
            
            break if victory_check(response)
            break if lose_check
            end_turn(guess, response)
            sleep 1
        end
    end
    
    def prompt_guess
        puts "Please enter your guess for the 4-number combination (guesses of number 1 through 6, separated by spaces): "
        guess = gets.chomp
        @turns = 12 if guess == "quit"
        puts @correct_combination if guess == "answer"
        guess.gsub!(/\D/, " ")
        guessArray = guess.split(/\s+/)
        guessArray.map!{|i| i.to_i}
        @previous_guesses[@turns] = guessArray
        guessArray
    end
    
    def test_guess(guessArray)
        response_array = [:N, :N, :N, :N]
        @correct_combination.each_with_index do |answer, position|
            guessArray.each_with_index do |guess, guess_position|
                if guess == answer && position == guess_position
                    response_array[position] = :Y
                    break
                elsif guess == answer
                    response_array[position] = :M
                end
            end
        end
        response_array
    end
    
    def end_turn(guess, response)
        
        correct_place = response.count(:Y)
        correct_number = response.count(:M)
        @previous_responses[@turns][0] = correct_place
        @previous_responses[@turns][1] = correct_number
        puts "You guessed the combination: #{guess}"
        puts "You had #{correct_place} numbers that were correct and in the right place"
        puts "You had #{correct_number} numbers that were correct but in the wrong place"
        @turns += 1
        display_board
    end

    def display_board
        @previous_guesses.each_with_index do |guess, turn|
            guess.each do |i|
                print "| #{i} |"
            end
            print @previous_responses[turn][0]
            print "Y "
            print @previous_responses[turn][1]
            print "M"
            print "\n"
            puts "-------------------------"
        end
    end
    
    def victory_check(response)
        if response == [:Y, :Y, :Y, :Y]
            puts "You have guessed the correct code! Congradudelations!"
            true
        end
    end
    
    def lose_check
        if @turns > 11
            puts "You are out of turns, you LOOOSEEEE!"
            true
        end
end
    
game = MastermindBoard.new