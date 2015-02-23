require 'socket'
require 'json'

def parse_request(request)
#    requests = request.split(" ")
#    case requests[0]
#      when "GET" then return request[1]
#    else "Request does not exist"
#    end
end

        
        
server = TCPServer.open(2000)
loop do
    client = server.accept
#    path = parse_request(client.gets)
#    request = []
#    while line = client.gets
#        request << line
#    end
    request = client.gets
    
    puts request
    
    requests = request.split(" ")
    path = requests[1]
    path = 'index.html' if path == '/' || path == ''
#    puts requests[0] == 'POST'
    if requests[0] == 'GET'
        if File.exists?(path)
            client.puts File.read(path)
        else
            client.puts "404 error, file you are looking for does not exist"
        end
    elsif requests[0] == 'POST'
        params = JSON.parse(requests[3])
        list = "<li>Name: #{params["viking"]["name"]}</li><li>Email: #{params["viking"]["email"]}</li>"
        file = File.read(path)
        client.puts(file.gsub('<%= yield %>', list))
    else
        client.puts "request not understood"
    end
    
    client.close
end