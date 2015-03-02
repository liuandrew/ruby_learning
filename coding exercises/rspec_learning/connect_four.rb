#board 7x6
class ConnectFourBoard
    def initialize
        @board = Hash.new
        7.times do |x|
            6.times do |y|
                @board[[x, y]] = " "
            end
        end
        
    end
    
    def start
        game_loop
    end
    #column -> x
    #row -> y
    
    def game_loop(brk = false)
        team = :X
        loop do
            graphical_display
            break if turn(team) || brk
            team = change_team(team)
        end
    end
    
    def graphical_display
        5.downto(0) do |i|
            puts "  -----------------------------"
            puts "#{i+1} | #{@board[[0,i]]} | #{@board[[1,i]]} | #{@board[[2,i]]} | #{@board[[3,i]]} | #{@board[[4,i]]} | #{@board[[5,i]]} | #{@board[[6,i]]} | "
        end
        puts "  -----------------------------"
        puts "    1   2   3   4   5   6   7   "
        
    end
    
    def change_team(team)
        return :O if team == :X
        :X
    end
    
    def board
        @board
    end 
    
    def set_space(space, team)
        @board[space] = team
        "#{space} set to #{team}"
    end
    
    def get_space(space)
        @board[space]
    end
    
    def left(space)
        [space[0]-1, space[1]]
    end
    
    def right(space)
        [space[0]+1, space[1]]
    end
    
    def up(space)
        [space[0], space[1]+1]
    end
    
    def down(space)
        [space[0], space[1]-1]
    end
    
    def drop_piece(column, team)
        row = 0
        while @board[[column, row]] != " "
            row += 1
            if row > 5
                graphical_display
                puts "That column was full, please try again"
                turn(team)
                return
            end
        end
        
        space = [column, row]
        
        @board[space] = team
        
        if win_check(space, team) || draw_check
            true
        end
    end
    #first set team of space to whatever
    #then send in space including team for win condition
    def turn(team, io = $stdin)
        puts "It is now time for team #{team} to place their piece"
        print "Please choose a column to place a piece in: "
        input = io.gets.chomp
        
        if input == "quit"
            return true
        end
        
        if (input =~ /^\d$/) == nil || input.to_i < 1 || input.to_i > 7
            graphical_display
            puts "That was not a valid input, please try again"
            turn(team)
        else
            drop_piece(input.to_i - 1, team)
        end
        
    end
    
    def draw_check
        @board.any?{|space, team| team == " "} ? false : true
    end
    
    def win_check(space, team)
        horizontal = 1; vertical = 1; diagonal_up_right = 1; diagonal_down_right = 1;
        
        marker = space
        while left(marker)[0] >= 0 && @board[left(marker)] == team
            horizontal += 1
            marker = left(marker)
        end
        marker = space
        while right(marker)[0] <= 6 && @board[right(marker)] == team
            horizontal += 1
            marker = right(marker)
        end
        marker = space
        while down(marker)[1] >= 0 && @board[down(marker)] == team
            vertical += 1
            marker = down(marker)
        end
        marker = space
        while up(marker)[1] <= 5 && @board[up(marker)] == team
            vertical += 1
            marker = up(marker)
        end

        marker = space
        while left(marker)[0] >= 0 && down(marker)[1] >= 0 && @board[left(down(marker))] == team
            diagonal_up_right += 1
            marker = left(down(marker))
        end
        marker = space
        while right(marker)[0] <= 6 && down(marker)[1] >= 0 && @board[right(down(marker))] == team
            diagonal_down_right += 1
            marker = right(down(marker))
        end
        marker = space
        while left(marker)[0] >= 0 && up(marker)[1] <= 5 && @board[left(up(marker))] == team
            diagonal_down_right += 1
            marker = left(up(marker))
        end
        marker = space
        while right(marker)[0] <= 6 && up(marker)[1] <= 5 && @board[right(up(marker))] == team
            diagonal_up_right += 1
            marker = right(up(marker))
        end
        
        if vertical >= 4 || horizontal >= 4 || diagonal_up_right >= 4 || diagonal_down_right >= 4
            win(team)
            true
        end
    end
    
    def draw
        graphical_display
        puts "The game is over because the board is filled. It's a draw!"
    end
    
    def win(team)
        graphical_display
        puts "The game is over, team #{team} has won!"
    end
end

board = ConnectFourBoard.new
board.start