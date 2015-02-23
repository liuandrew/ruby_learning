class TicTacToeBoard
    def initialize
        @current_board = []
        @whos_turn = :X
        9.times {@current_board.push("     ")}
        game_loop
    end
    

    private
    
    def display_board
        puts "#{@current_board[0]}|#{@current_board[1]}|#{@current_board[2]}"
        puts "----------------"
        puts "#{@current_board[3]}|#{@current_board[4]}|#{@current_board[5]}"
        puts "----------------"
        puts "#{@current_board[6]}|#{@current_board[7]}|#{@current_board[8]}"
    end
    
    def victory_check
      if 
(@current_board[0] == "  X  " && @current_board[1] == "  X  " && @current_board[2] == "  X  ") || (@current_board[3] == "  X  " && @current_board[4] == "  X  " && @current_board[5] == "  X  ") || (@current_board[6] == "  X  " && @current_board[7] == "  X  " && @current_board[8] == "  X  ") ||
(@current_board[0] == "  X  " && @current_board[3] == "  X  " && @current_board[6] == "  X  ") ||
(@current_board[1] == "  X  " && @current_board[4] == "  X  " && @current_board[7] == "  X  ") ||
(@current_board[2] == "  X  " && @current_board[5] == "  X  " && @current_board[8] == "  X  ") ||
(@current_board[0] == "  X  " && @current_board[4] == "  X  " && @current_board[8] == "  X  ") ||
(@current_board[6] == "  X  " && @current_board[4] == "  X  " && @current_board[2] == "  X  ")
          puts "X has completed three in a row, X wins!"
          true
      elsif 
(@current_board[0] == "  O  " && @current_board[1] == "  O  " && @current_board[2] == "  O  ") || (@current_board[3] == "  O  " && @current_board[4] == "  O  " && @current_board[5] == "  O  ") || (@current_board[6] == "  O  " && @current_board[7] == "  O  " && @current_board[8] == "  O  ") ||
(@current_board[0] == "  O  " && @current_board[3] == "  O  " && @current_board[6] == "  O  ") ||
(@current_board[1] == "  O  " && @current_board[4] == "  O  " && @current_board[7] == "  O  ") ||
(@current_board[2] == "  O  " && @current_board[5] == "  O  " && @current_board[8] == "  O  ") ||
(@current_board[0] == "  O  " && @current_board[4] == "  O  " && @current_board[8] == "  O  ") ||
(@current_board[6] == "  O  " && @current_board[4] == "  O  " && @current_board[2] == "  O  ")
          puts "O has completed three in a row, O wins!"
          true
      end
    end
    
    def game_complete_check
        if @current_board.none? {|entry| entry == "     "}
            puts "No more moves possible; the game has ended in a tie!"
            true
        else
            false
        end
    end

    def turn
        puts "It is now #{@whos_turn.to_s}'s turn, where would you like to place your piece?"
        row = prompt_row
        column = prompt_column
        place = (row-1)*3 + (column-1)
        
        if @current_board[place] != "     "
            puts "There is already a piece there, please choose a new spot"
            turn
            return
        end
        
        if @whos_turn == :X
            @current_board[place] = "  X  "
            @whos_turn = :O
            return
        elsif @whos_turn == :O
            @current_board[place] = "  O  "
            @whos_turn = :X
            return
        end
    end

    def prompt_row
        puts "Input which row you would like to place your piece: "
        row = gets.chomp.to_i
        if row > 0 && row < 4
            row
        else
            puts "That is not a valid row. "
            prompt_row
        end
    end

    def prompt_column
        puts "Input which row you would like to place your piece: "
        column = gets.chomp.to_i
        if column > 0 && column < 4
            column
        else
            puts "That is not a valid row. "
            prompt_column
        end
    end

    def game_loop
        loop do
            display_board
            break if game_complete_check || victory_check
            turn
        end
    end
end

board = TicTacToeBoard.new
