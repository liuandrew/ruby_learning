i = 1
j = 0
until i > 1000000
    i*=2
    j+=1
end
puts "i = #{i}, j = #{j}"

##$ruby -rdebug script.rb  to start
#break (line n) for break point
#cont to go until break or watch
#watch (condition) for watch point
#step to next line
#v g/l/i/c shows vars global/local/instance/constants
#or vars can be individually checked just by calling them