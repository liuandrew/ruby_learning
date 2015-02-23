    ##probability of occurence:
#x = 0
#100.times do |i|
#    x += (0.01*(0.99**i))
#end
#puts 1-x



    #100 times catch 23:
catch(:finish) do
    
    100.times do
        x = rand(100)
        puts x
        throw :finish if x==23
        
    end
    puts "Generated 100 random numbers without hitting 23!"
end