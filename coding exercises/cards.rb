#deck = []
#
#def card(value, suit, deck)
#    
#end
#
#12.times do |value|
#    4.times do |suit|
#        case value
#            when 0 then
#                case suit
#        when 0 then deck.push(["ace", "spades"])
#        when 1 then deck.push(["ace", "clubs"])
#        when 2 then deck.push(["ace", "hearts"])
#        when 3 then deck.push(["ace", "diamonds"])
#    end
#            when 1 then 
#                case suit
#        when 0 then deck.push(["two", "spades"])
#        when 1 then deck.push(["two", "clubs"])
#        when 2 then deck.push(["two", "hearts"])
#        when 3 then deck.push(["two", "diamonds"])
#    end
#            when 2 then case suit
#        when 0 then deck.push(["three", "spades"])
#        when 1 then deck.push(["three", "clubs"])
#        when 2 then deck.push(["three", "hearts"])
#        when 3 then deck.push(["three", "diamonds"])
#    end
#            when 3 then case suit
#        when 0 then deck.push(["four", "spades"])
#        when 1 then deck.push(["four", "clubs"])
#        when 2 then deck.push(["four", "hearts"])
#        when 3 then deck.push(["four", "diamonds"])
#    end
#            when 4 then case suit
#        when 0 then deck.push(["five", "spades"])
#        when 1 then deck.push(["five", "clubs"])
#        when 2 then deck.push(["five", "hearts"])
#        when 3 then deck.push(["five", "diamonds"])
#    end
#            when 5 then case suit
#        when 0 then deck.push(["six", "spades"])
#        when 1 then deck.push(["six", "clubs"])
#        when 2 then deck.push(["six", "hearts"])
#        when 3 then deck.push(["six", "diamonds"])
#    end
#            when 6 then case suit
#        when 0 then deck.push(["seven", "spades"])
#        when 1 then deck.push(["seven", "clubs"])
#        when 2 then deck.push(["seven", "hearts"])
#        when 3 then deck.push(["seven", "diamonds"])
#    end
#            when 7 then case suit
#        when 0 then deck.push(["eight", "spades"])
#        when 1 then deck.push(["eight", "clubs"])
#        when 2 then deck.push(["eight", "hearts"])
#        when 3 then deck.push(["eight", "diamonds"])
#    end
#            when 8 then case suit
#        when 0 then deck.push(["nine", "spades"])
#        when 1 then deck.push(["nine", "clubs"])
#        when 2 then deck.push(["nine", "hearts"])
#        when 3 then deck.push(["nine", "diamonds"])
#    end
#            when 9 then case suit
#        when 0 then deck.push(["ten", "spades"])
#        when 1 then deck.push(["ten", "clubs"])
#        when 2 then deck.push(["ten", "hearts"])
#        when 3 then deck.push(["ten", "diamonds"])
#    end
#            when 10 then case suit
#        when 0 then deck.push(["jack", "spades"])
#        when 1 then deck.push(["jack", "clubs"])
#        when 2 then deck.push(["jack", "hearts"])
#        when 3 then deck.push(["jack", "diamonds"])
#    end
#            when 11 then case suit
#        when 0 then deck.push(["queen", "spades"])
#        when 1 then deck.push(["queen", "clubs"])
#        when 2 then deck.push(["queen", "hearts"])
#        when 3 then deck.push(["queen", "diamonds"])
#    end
#            when 12 then case suit
#        when 0 then deck.push(["king", "spades"])
#        when 1 then deck.push(["king", "clubs"])
#        when 2 then deck.push(["king", "hearts"])
#        when 3 then deck.push(["king", "diamonds"])
#    end
#        end
#    end
#end
#    
#5.times {deck.shuffle!}
#                
#loop do
#    command = gets.chomp
#    if command == "quit"
#        break
#    elsif command == "draw"
#        card = deck.pop
#        puts "Card drawn: #{card[0]} of #{card[1]}"
#    elsif command == "deck"
#        deck.each do |card|
#            puts card
#        end
#    end
#end

class Card
    def to_s
        value = case @value
        end
        suit = case @suit
        end
end
    
class Deck
    
end
    
class SeventeenPoker < Deck
    
end
    
    