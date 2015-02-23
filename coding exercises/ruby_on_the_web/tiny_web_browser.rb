require 'socket'
require 'json'

host = 'localhost'
port = 2000

printf "Would you like to GET or POST? "

user_input = gets.chomp.downcase

if user_input == 'get'
    path = "./index.html"

    request = "GET #{path} HTTP/1.0\r\n\r\n"

    socket = TCPSocket.open(host, port)
    socket.puts(request)
    response = socket.read
    puts response
elsif user_input == 'post'
    path = "./thanks.html"
    
    viking_attributes = Hash.new
    
    printf "What is the name of your viking? "
    viking_attributes[:name] = gets.chomp
    printf "What is your viking's email? "
    viking_attributes[:email] = gets.chomp
    
    viking = {viking: viking_attributes}
    
    puts viking.to_json
    
    request = %Q{POST #{path} HTTP/1.0 #{viking.to_json} #{viking.to_json.length}}
    
    socket = TCPSocket.open(host, port)
    socket.puts(request)
#    socket.print(request)
    response = socket.read
    puts response
end

#headers, body = response.split("\r\n\r\n", 2)
#print body