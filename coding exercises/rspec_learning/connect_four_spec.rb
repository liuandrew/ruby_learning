require_relative "./connect_four"

describe ConnectFourBoard do
    before :each do
        @board = ConnectFourBoard.new
        
    end
    
    it "should initialize a 7x6 empty board" do
        expect(@board.get_space([0,0])).to eq " "
        expect(@board.get_space([6,0])).to eq " "
        expect(@board.get_space([0,5])).to eq " "
        
        expect(@board.get_space([7,0])).to eq nil
        expect(@board.get_space([0,6])).to eq nil
    end
    
    describe ".board" do
        it "returns the board state" do
            expect(@board.board.class).to eq Hash
        end
    end
    
    describe ".set_space" do
        it "sets the team of a given space" do
            expect(@board.set_space([1, 1], :O)).to eql "[1, 1] set to O"
        end
    end
    
    describe ".get_space" do
        it "returns the team in the space" do
            @board.set_space([1, 1], :O)
            expect(@board.get_space([1, 1])).to eql :O
        end
    end
    
    describe ".graphical_display" do
        it "prints a graphical display of the board in command line" do
        end
    end
    
    describe ".turn" do
        
#        it "reprompts user if invalid column input" do
#            io = StringIO.new
#            io.puts "hello"
#            io.rewind
#            allow(@board).to receive(:turn)
#            expect(@board).to receive(:turn).twice
#                @board.turn(:X, io)
#        end
        
        it "calls '.drop_piece' on valid column input" do
            io = StringIO.new
            io.puts "5"
            io.rewind
            expect(@board).to receive(:drop_piece)
            @board.turn(:X, io)

#            expect(@board.get_space([3, 0])).to eq :X
        end
    end
    
    describe ".drop_piece" do
        it "places a piece in the next available slot of a given column" do
            @board.drop_piece(3, :X)
            expect(@board.get_space([3, 0])).to eq :X
            @board.drop_piece(3, :O)
            expect(@board.get_space([3, 1])).to eq :O
        end
        
        it "calls '.win_check' to check for any wins" do
            expect(@board).to receive(:win_check)
            @board.drop_piece(3, :X)
        end

        it "calls '.draw_check' to check for a draw" do
            expect(@board).to receive(:draw_check)
            @board.drop_piece(3, :X)
        end
        
        it "calls '.turn' again if column is full" do
            allow(@board).to receive(:graphical_display)
            expect(@board).to receive(:turn)
            6.times do |i|
                @board.set_space([3, i], :X)
            end
            @board.drop_piece(3, :X)
        end
    end

    describe ".draw_check" do
        it "returns false if board has empty spaces" do
            allow(@board).to receive(:graphical_display)
            expect(@board.draw_check).to eq false
        end
        
        it "returns true if board is full" do
            @board.board.each {|space, team| @board.set_space(space, :X)}
            allow(@board).to receive(:graphical_display)
            expect(@board.draw_check).to eq true
            
        end
    end
    
    describe ".game_loop" do
        it "calls '.turn'" do
            expect(@board).to receive(:turn)
            allow(@board).to receive(:graphical_display)
            @board.game_loop(true)
        end
        
        it "stops the loop if a draw or win condition is fulfilled" do
            allow(@board).to receive(:turn)
            allow(@board).to receive(:graphical_display)
            expect(@board).not_to receive(:change_team)
            @board.game_loop(true)
        end
        
        it "calls '.graphical_display'" do
            expect(@board).to receive(:graphical_display)
            allow(@board).to receive(:turn)
            @board.game_loop(true)
        end
    end
    
    describe ".change_team" do
        it "returns the opposite team of the one it is passed" do
            expect(@board.change_team :X).to eq :O
            expect(@board.change_team :O).to eq :X
        end
    end
    
    describe ".draw" do
        it "Outputs that the game is a draw" do
            expect(STDOUT).to receive(:puts).with("The game is over because the board is filled. It's a draw!")
            allow(@board).to receive(:graphical_display)
            @board.draw
        end
    end
    
    describe ".win_check" do
        #vertical win tests
        context "with 4 or more pieces of one team in a vertical column" do
            it "calls '.win'" do
                4.times do |i|
                    @board.set_space([3, i], :X)
                end
                expect(@board).to receive(:win).with(:X)
                @board.win_check([3, 1], :X)
                @board.set_space([3, 4], :X)
                expect(@board).to receive(:win).with(:X)
                @board.win_check([3, 4], :X)
            end
        end
        context "with 3 or fewer pieces of one team in a vertical column" do
            it "does not call '.win'" do
                3.times do |i|
                    @board.set_space([3, i], :X)
                end
                expect(@board).not_to receive(:win)
                @board.win_check([3, 1], :X)
            end
        end
        
        #horizontal win tests
        context "with 4 or more pieces of one team in a horizontal row" do
            it "calls '.win'" do
                4.times do |i|
                    @board.set_space([i, 2], :X)
                end
                expect(@board).to receive(:win).with(:X)
                @board.win_check([1, 2], :X)
                @board.set_space([4, 2], :X)
                expect(@board).to receive(:win).with(:X)
                @board.win_check([4, 2], :X)
            end
        end
        context "with 3 or fewer pieces of one team in a horizontal row" do
            it "does not call '.win'" do
                3.times do |i|
                    @board.set_space([i, 2], :X)
                end
                expect(@board).not_to receive(:win)
                @board.win_check([1, 2], :X)
            end
        end
        
        #diagonal up-right win tests
        context "with 4 or more pieces of one team in a diagonal up-right row" do
            it "calls '.win'" do
                4.times do |i|
                    @board.set_space([i, i], :X)
                end
                expect(@board).to receive(:win).with(:X)
                @board.win_check([1, 1], :X)
                @board.set_space([4, 4], :X)
                expect(@board).to receive(:win).with(:X)
                @board.win_check([4, 4], :X)
            end
        end
        context "with 3 or fewer pieces of one team in a diagonal up-right row" do
            it "does not call '.win'" do
                3.times do |i|
                    @board.set_space([i, i], :X)
                end
                expect(@board).not_to receive(:win)
                @board.win_check([1, 1], :X)
            end
        end
        
        #diagonal down-right win tests
        context "with 4 or more pieces of one team in a diagonal down-right row" do
            it "calls '.win'" do
                4.times do |i|
                    @board.set_space([i+1, (4-i)], :X)
                end
                #spaces occupied: [1, 4], [2, 3], [3, 2], [4, 1]
                expect(@board).to receive(:win).with(:X)
                @board.win_check([2, 3], :X)
                @board.set_space([5, 0], :X)
                expect(@board).to receive(:win).with(:X)
                @board.win_check([5, 0], :X)
            end
        end
        context "with 3 or fewer pieces of one team in a diagonal down-right row" do
            it "does not call '.win'" do
                3.times do |i|
                    @board.set_space([i+1, 4-i], :X)
                end
                expect(@board).not_to receive(:win)
                @board.win_check([1, 4], :X)
            end
        end
    end
    
    describe ".win" do
        it "outputs the proper team as winning" do
            expect(STDOUT).to receive(:puts).with("The game is over, team X has won!")
            allow(@board).to receive(:graphical_display)
            @board.win(:X)
        end
    end
end