require_relative "./pieces.rb"

class ChessBoard
    #@board is a hash: @board[space] == piece
    #spaces defined as bottom left = 0, 0, up to max of 7, 7 in the top right
    
    def initialize
        initialize_board
    end
    
#    def undo
#        piece = @last_move[2]
#        
##        @board[@last_move[0]] = @board[@last_move[1]]
#        move_piece(@last_move[1], @last_move[0])
#        @board[@last_move[1]] = piece
#        
#        
#    end
    
    def move_piece(initial, final)
        
        
        if (initial == [4, 0] || initial == [4, 7]) && space(initial).class == King
            if final == [2, 0]
                move_piece([0, 0], [3, 0])
            elsif final == [6, 0] 
                move_piece([7, 0], [5, 0])
            elsif final == [2, 7] 
                move_piece([0, 7], [3, 7])
            elsif final == [6, 7]
                move_piece([7, 7], [5, 7])
            end
        end 
        
        removed_piece = nil
        if space(final) != " " && space(final).team == opposite_team(space(initial).team)
            puts "#{space(initial).team.to_s.capitalize} #{space(initial).class} takes #{opposite_team(space(initial).team).to_s} #{space(final).class}"
            removed_piece = space(final)
        end
        @board[initial].move(final)
        @board[final] = @board[initial]
        @board[initial] = " "
        
        if space(final).class == Pawn && (final[1] == 7 || final[1] == 0)
            pawn_promotion(final, space(final).team)
        end
        
        @last_move = [initial, final, removed_piece]
    end
    
    def initialize_board
        @board = Hash.new
        8.times do |x|
            8.times do |y|
                @board[[x, y]] = " "
            end
        end
        @board[[0, 0]] = Rook.new([0, 0], :white)
        @board[[1, 0]] = Knight.new([1, 0], :white)
        @board[[2, 0]] = Bishop.new([2, 0], :white)
        @board[[3, 0]] = Queen.new([3, 0], :white)
        @board[[4, 0]] = King.new([4, 0], :white)
        @board[[5, 0]] = Bishop.new([5, 0], :white)
        @board[[6, 0]] = Knight.new([6, 0], :white)
        @board[[7, 0]] = Rook.new([7, 0], :white)
        8.times {|x| @board[[x, 1]] = Pawn.new([x, 1], :white)}
        @white_king = @board[[4, 0]]
        
        @board[[0, 7]] = Rook.new([0, 7], :black)
        @board[[1, 7]] = Knight.new([1, 7], :black)
        @board[[2, 7]] = Bishop.new([2, 7], :black)
        @board[[3, 7]] = Queen.new([3, 7], :black)
        @board[[4, 7]] = King.new([4, 7], :black)
        @board[[5, 7]] = Bishop.new([5, 7], :black)
        @board[[6, 7]] = Knight.new([6, 7], :black)
        @board[[7, 7]] = Rook.new([7, 7], :black)
        8.times {|x| @board[[x, 6]] = Pawn.new([x, 6], :black)}
        @black_king = @board[[4, 7]]
    end
    
    def display_board
        puts "    A   B   C   D   E   F   G   H"
        puts "  ---------------------------------"
        8.times do |row|
            puts "#{8-row} | #{@board[[0, 7-row]].to_s} | #{@board[[1, 7-row]].to_s} | #{@board[[2, 7-row]].to_s} | #{@board[[3, 7-row]].to_s} | #{@board[[4, 7-row]].to_s} | #{@board[[5, 7-row]].to_s} | #{@board[[6, 7-row]].to_s} | #{@board[[7, 7-row]].to_s} | "
            puts "  ---------------------------------"
        end
        puts "    A   B   C   D   E   F   G   H"
    end
    
    def space(space)
        @board[space]
    end
    
    def set_space(space, piece)
        @board[space] = piece
    end
        
    def opposite_team(team)
        return :black if team == :white
        return :white
    end
    
    def total_moves(team)
        white_moves = []
        black_moves = []
        @board.each do |space, piece|
            next if piece == " "
            if piece.team == :white
                white_moves += piece.get_moves(self, true)
            elsif piece.team == :black
                black_moves += piece.get_moves(self, true)
            end
        end
        if team == :white
            return white_moves
        elsif team == :black
            return black_moves
        end
    end
    
    def king(team)
        if team == :white
            return @white_king
        elsif team == :black
            return @black_king
        end
    end
    
    def check_check(team)
        if total_moves(team).any?{|space| space == king(opposite_team(team)).space}
            if total_moves(opposite_team(team)).empty?
                puts "#{opposite_team(team).to_s.capitalize}'s king has been put into checkmate!"
                puts "#{team.to_s.capitalize} team wins!"
                return true
            end
            puts "#{opposite_team(team).to_s.capitalize} king in check."
            return false
        end
    end
    
    def pawn_promotion(space, team)
        puts "What piece would you like to promote this pawn to? (Knight, Bishop, Rook, Queen)"
        brk = false
        loop do
            input = gets.chomp.downcase
            if input == "knight"
                set_space(space, Knight.new(space, team))
                brk = true
            elsif input == "bishop"
                set_space(space, Bishop.new(space, team))
                brk = true
            elsif input == "rook"
                set_space(space, Rook.new(space, team))
                brk = true
            elsif input == "queen"
                set_space(space, Queen.new(space, team))
                brk = true
            else
                puts "That was not a valid piece."
            end
            break if brk
        end
    end
end