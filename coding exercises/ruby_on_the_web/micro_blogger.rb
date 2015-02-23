require 'jumpstart_auth'
require 'bitly'

Bitly.use_api_version_3

class MicroBlogger
    attr_reader :client
    
    def initialize
        puts "Initializing MicroBlogger"
        @client = JumpstartAuth.twitter
    end
    
    def tweet(message)
        @client.update(message)
    end
    
    def dm(target, message)
        follower_names = @client.followers.collect {|follower| @client.user(follower).screen_name}
        
        if follower_names.include?(target)
            puts "Trying to send #{target} this dm:"
            puts message
            message = "d @#{target} #{message}"
            tweet(message)
        else
            puts "Your target does not follow you!"
        end
    end
    
    def followers_list
        follower_names = @client.followers.collect{|follower| @client.user(follower).screen_name}
        follower_names
    end
    
    def spam_my_followers(message)
        follower_names = followers_list
        follower_names.each do |follower|
            message = "d @#{follower} #{message}"
            tweet(message)
        end
    end
    
    def everyones_last_tweet
        friends = @client.friends
        friends.sort_by {|friend| friend.screen_name.downcase}
        friends.each do |friend|
            puts friend.status.text
            timestamp = friend.status.created_at
            timestamp.strftime("%A, %b %d")
        end
    end
    
    def shorten(original_url)
        puts "Shortening this URL: #{original_url}"
        bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
        bitly.shorten(original_url).short_url
        
    end
    
    def run
        puts "Welcome to the JSL Twitter Client"
        command = ""
        while command != "q"
            printf "enter command: "
            input = gets.chomp
            parts = input.split(" ")
            command = parts[0]
            case command
              when 'q' then puts "Goodbye!"
              when 't' then tweet(parts[1..-1].join(" ")) 
              when 'dm' then dm(parts [1], parts[2..-1].join(" "))
              when 'spam' then spam_my_followers(parts[1..-1].join(" "))
              when 's' then shorten(parts[1])
              when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
              else puts "That was not a valid command!"
            end
        end
    end
end

blogger = MicroBlogger.new
blogger.run