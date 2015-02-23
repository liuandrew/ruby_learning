dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(string, words)
    string.downcase!
    resultHash = {}
    words.each do |word|
        a = (string.scan(word)).length
        resultHash[word] = a if a > 0
    end
    resultHash
end

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
