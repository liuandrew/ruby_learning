require 'net/http'

def get_web_document(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    
    case response
      when Net::HTTPSuccess
        return response.body
      when Net::HTTPRedirection
        return get_web_document(response['Location'])
      when Net::HTTPNotFound
        return "404 error caught"
      when Net::HTTPForbidden
        return "403 error caught"
      else
        return nil
    end
end

puts get_web_document('http://www.rubyinside.com/test.txt')
puts get_web_document('http://www.rubyinside.com/non-existent')
puts get_web_document('http://www.rubyinside.com/redirect-test')

url = URI.parse('http://rubyinside.com/test.cgi')

response = Net::HTTP.post_form(url,{'id' => 4, 'name' => 'Andy', 'age' => '18'})
puts response.body