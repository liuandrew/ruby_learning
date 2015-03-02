require_relative "./board.rb"

class ChessGame
    attr_reader :board
    
    def initialize
        @whos_turn = :white
        @board = ChessBoard.new
        game_loop
    end
    
    def game_loop
        loop do
            break if turn
        end
        nil
    end
    
    def turn
        @board.display_board
        initial = nil; final = nil
        loop do
            initial = initial_space
            return true if initial == :surrender
            break if initial
        end
        
        loop do
            final = final_space(initial)
            if final == :cancel
                turn
                return
            end
            break if final
        end
        
        @board.move_piece(initial, final)
        
        @whos_turn = change_team(@whos_turn)
        
        return @board.check_check(change_team(@whos_turn))
    end
        
    def initial_space
        puts "It is now #{@whos_turn}'s move"
        puts "Please select which piece you would like to move"
        input = gets.chomp
        if (input.downcase == "surrender")
            puts "Are you sure?"
            input = gets.chomp
            if (input.downcase == "yes")
                puts "#{@whos_turn} surrenders!"
                puts "#{change_team(@whos_turn)} wins!"
                return :surrender
            end
        end
        if !(input =~ /^\D\d$/)
            puts "That was not a valid selection"
            return false
        end
        
        input.downcase!
        
        space = [input[0].ord-97, input[1].to_i - 1]
        
        if @board.space(space) == " "
            puts "That space is empty, please select another"
            return false
        elsif @board.space(space).team != @whos_turn
            puts "That piece does not belong to your team, please select another"
            return false
        elsif @board.space(space).team == @whos_turn
            if @board.space(space).has_moves?(@board)
                puts "You have selected the #{@whos_turn} #{@board.space(space).class} at space #{input[0].upcase}#{input[1]}"
                return space
            else
                puts "That piece has no valid moves, please select another"
                return false
            end
        end
    end

    def final_space(initial)
        puts "Please select a space to move this piece to"
        puts "Type 'cancel' to choose a different piece"
        input = gets.chomp
        if input.downcase == "cancel"
            return :cancel
        end
        if !(input =~ /^\D\d$/)
            puts "That was not a valid selection"
            return false
        end
        
        input.downcase!
        
        space = [input[0].ord-97, input[1].to_i - 1]
        
        if @board.space(initial).get_moves(@board).any? {|move| move == space}
            puts "Moving #{@whos_turn}'s #{@board.space(initial).class} to space #{input[0].upcase}#{input[1]}"
            return space
        else
            puts "The #{@whos_turn} #{@board.space(initial).class} cannot move there"
            return false
        end
    end
    
    def change_team(team)
        return :black if team == :white
        return :white
    end
end