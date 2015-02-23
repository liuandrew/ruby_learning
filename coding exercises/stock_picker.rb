
stocks = [5, 2, 17, 4, 12, 8, 19, 20]
currentBest = [0, 0, 0] #profit, start, finish

#Compare current day with all days ahead of it and choose the best profit
def findHighestProfit(key, stocks, currentBest)
    for i in key+1..stocks.length-1
        if (difference = stocks[i] - stocks[key]) > currentBest[0]
            currentBest[0] = difference
            currentBest[1] = key
            currentBest[2] = i
        end
    end
    return currentBest
end

#Run findHighestProfit for each day starting on day 1
stocks.each_index do |i|
    currentBest = findHighestProfit(i, stocks, currentBest)
end

puts "The best profit is: #{currentBest[0]}, buying on day #{currentBest[1]+1}, and selling on day #{currentBest[2]+1}"