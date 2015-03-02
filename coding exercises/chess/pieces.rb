class Piece
    attr_reader :team, :space, :has_moved
    
    def initialize(space, team)
        @space = space
        @team = team
        @has_moved = false
    end
    
    def move(space)
        @has_moved = true
        @space = space
    end
    
    def has_moves?(board)
        !get_moves(board).empty?
    end
    
    def to_s; end
    
    def get_moves; end
    
    def up(space = @space); [space[0], space[1] + 1]; end
    def down(space = @space); [space[0], space[1] - 1]; end
    def left(space = @space); [space[0] - 1, space[1]]; end
    def right(space = @space); [space[0] + 1, space[1]]; end
    def up_right(space = @space); [space[0] + 1, space[1] + 1]; end
    def down_right(space = @space); [space[0] + 1, space[1] - 1]; end
    def up_left(space = @space); [space[0] - 1, space[1] + 1]; end
    def down_left(space = @space); [space[0] - 1, space[1] - 1]; end
    
    def opposite_team
        return :black if team == :white
        return :white
    end

    def puts_in_check?(space, board, skip_check)
        if skip_check
            save_piece = board.space(space)
            board.set_space(self.space, " ")
            board.set_space(space, self)
            if board.total_moves(opposite_team).any?{|enemy_space| enemy_space == board.king(self.team).space}
                board.set_space(space, save_piece)
                board.set_space(self.space, self)
                return true
            else
                board.set_space(space, save_piece)
                board.set_space(self.space, self) 
                return false
            end
        else
            return false
        end
    end
end

class Knight < Piece
    def get_moves(board, skip_check = false)
        moves = []
    
        test_moves = [left(up_left), left(down_left), up(up_left), down(down_left), right(up_right), right(down_right), up(up_right), down(down_right)]
        test_moves.each do |space|
            moves << space if board.space(space) != nil && (board.space(space) == " " || board.space(space).team == opposite_team) && !puts_in_check?(space, board, !skip_check)
        end
        
        moves
    end
    
    def to_s
        if @team == :white
            "\u{2658}" 
        elsif @team == :black
            "\u{265E}" 
        end
    end
end

class Rook < Piece
    def get_moves(board, skip_check = false)
        moves = []
        test_moves = [:up, :down, :left, :right]
        test_moves.each do |direction|
            marker = @space
            while board.space(method(direction).call(marker)) != nil && !puts_in_check?(marker, board, !skip_check)
                marker = method(direction).call(marker)
                if !puts_in_check?(marker, board, !skip_check) && board.space(marker) == " "
                    moves << marker
                elsif !puts_in_check?(marker, board, !skip_check) && board.space(marker).team == @team
                    break
                elsif !puts_in_check?(marker, board, !skip_check) && board.space(marker).team == opposite_team
                    moves << marker
                    break
                end
            end
        end
        moves
    end
    
    def to_s
        if @team == :white
            "\u{2656}" 
        elsif @team == :black
            "\u{265C}"
        end
    end
end

class Bishop < Piece
    def get_moves(board, skip_check = false)
        moves = []
        test_moves = [:up_right, :down_right, :up_left, :down_left]
        test_moves.each do |direction|
            marker = @space
            while board.space(method(direction).call(marker)) != nil
                marker = method(direction).call(marker)
                if !puts_in_check?(marker, board, !skip_check) && board.space(marker) == " "
                    moves << marker
                elsif  !puts_in_check?(marker, board, !skip_check) && board.space(marker).team == @team
                    break
                elsif !puts_in_check?(marker, board, !skip_check) && board.space(marker).team == opposite_team
                    moves << marker
                    break
                end
            end
        end
        moves
    end
    
    def to_s
        if @team == :white
            return "\u{2657}"
        elsif @team == :black
            return "\u{265D}" 
        end
    end
end

class Queen < Piece
    def get_moves(board, skip_check = false)
        moves = []
        test_moves = [:up, :down, :left, :right, :up_right, :down_right, :up_left, :down_left]
        test_moves.each do |direction|
            marker = @space
            while board.space(method(direction).call(marker)) != nil
                marker = method(direction).call(marker)
                if !puts_in_check?(marker, board, !skip_check) && board.space(marker) == " "
                    moves << marker
                elsif !puts_in_check?(marker, board, !skip_check) && board.space(marker).team == @team
                    break
                elsif !puts_in_check?(marker, board, !skip_check) && board.space(marker).team == opposite_team
                    moves << marker
                    break
                end
            end
        end

        moves
    end
    
    def to_s
        if @team == :white
            "\u{2655}" 
        elsif @team == :black
            "\u{265B}"
        end
    end
end

class King < Piece
    def get_moves(board, skip_check = false)
        moves = []
        moves << right(right) if !@has_moved && board.space(right(right(right))).class == Rook && !board.space(right(right(right))).has_moved && board.space(right) == " " && board.space(right(right)) == " " && !puts_in_check?(right(right), board, !skip_check) && !puts_in_check?(@space, board, !skip_check)
        
        moves << left(left) if !@has_moved && board.space(left(left(left(left)))).class == Rook && !board.space(left(left(left(left)))).has_moved && board.space(left) == " " && board.space(left(left)) == " " && board.space(left(left(left))) == " " && !puts_in_check?(left(left), board, !skip_check) && !puts_in_check?(@space, board, !skip_check)
        
        test_moves = [up, down, left, right, up_right, down_right, up_left, down_left]

        test_moves.each do |space|
            moves << space if board.space(space) != nil && (board.space(space) == " " || board.space(space).team == opposite_team) && !puts_in_check?(space, board, !skip_check)
        end

        moves
    end
    
    def to_s
        if @team == :white
            "\u{2654}"
        elsif @team == :black
            "\u{265A}" 
        end
    end
    
    def puts_in_check?(space, board, skip_check)
        if skip_check
            save_piece = board.space(space)
            board.set_space(self.space, " ")
            board.set_space(space, self)
            if board.total_moves(opposite_team).any?{|enemy_space| enemy_space == space}
                board.set_space(space, save_piece)
                board.set_space(self.space, self)
                return true
            else
                board.set_space(space, save_piece)
                board.set_space(self.space, self) 
                return false
            end
        else
            return false
        end
    end
end

class Pawn < Piece
    def get_moves(board, skip_check = false)
        moves = []
        if @team == :white
            moves << up(up) if !@has_moved && board.space(up) == " " && board.space(up(up)) == " " && !puts_in_check?(up(up), board, !skip_check)
            moves << up if board.space(up) == " " && !puts_in_check?(up, board, !skip_check)
            moves << up_right if board.space(up_right) != nil && board.space(up_right) != " " && board.space(up_right).team == :black && !puts_in_check?(up_right, board, !skip_check)
            moves << up_left if board.space(up_left) != nil && board.space(up_left) != " " && board.space(up_left).team == :black && !puts_in_check?(up_left, board, !skip_check)
            
        elsif @team == :black
            moves << down(down) if !@has_moved && board.space(down) == " " && board.space(down(down)) == " " && !puts_in_check?(down(down), board, !skip_check)
            moves << down if board.space(down) == " " && !puts_in_check?(down, board, !skip_check)
            moves << down_right if board.space(down_right) != nil && board.space(down_right) != " " && board.space(down_right).team == :white && !puts_in_check?(down_right, board, !skip_check)
            moves << down_left if board.space(down_left) != nil && board.space(down_left) != " " && board.space(down_left).team == :white && !puts_in_check?(down_left, board, !skip_check)
        end
        moves
    end
    
    
    def to_s
        if @team == :white
            "\u{2659}" 
        elsif @team == :black
            "\u{265F}" 
        end
    end
end