#Incomplete, missing recursion

stocks = [2, 4, 3, 5, 6]
currentBest = [0, 0, 0] #profit, start, finish
choice_hash = {}

def compareToRemainingStocks(key, stocks)
    results = []
    for i in key+1..stocks.length-1
        results.push(i) if stocks[i] > stocks[key]
    end
    puts results
end

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

def findMax(startIndex, stopIndex, stocks)
    max = 0
    maxIndex = 0
    (stopIndex).downto(startIndex) do |j|
        if stocks[j] - stocks[startIndex] > max
            max = stocks[j] - stocks[startIndex] 
            maxIndex = j
        end
    end
    return max, maxIndex
end

for i in 0..stocks.length-1
    next if stocks[i+1] != nil && stocks[i+1] < stocks[i]
    one, maxIndex = findMax(i, stocks.length-1, stocks)
    
    a = 0
    b = []
    
    results = findMax(i, stocks.length-2, stocks)
    a += results[0]
    b.push(results[1])
    results = findMax(stocks.length-2, stocks.length-1, stocks)
    a += results[0]
    b.push(results[1])
    
#    findMax(i, stocks.length-3, stocks) + findMax(stocks.length-3, stocks.length-1, stocks)
#    findMax(i, stocks.length-3, stocks) + findMax(stocks.length-3, stocks.length-2, stocks) + findMax(stocks.length-2, stocks.length-1, stocks)
    puts a
end

