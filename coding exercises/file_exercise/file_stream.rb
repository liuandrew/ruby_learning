require 'yaml'
class Dragon
    attr_accessor :strength, :speed, :color
    def initialize(strength = 0, speed = 0, color = "green")
        @strength = strength
        @speed = speed
        @color = color
    end
    
    def to_s
        puts "I am a DRAGON!"
        puts "My strength is #{@strength}, my speed is #{@speed}, and I am #{@color}"
    end
    
    def save_dragon
        yaml = YAML::dump(self)
        dragon_file = File.new("a file.txt", 'r+')
        dragon_file.write(yaml)
    end
    
    def self.load_dragon
        dragon_file = File.new("a file.txt")
        YAML::load(dragon_file)
    end
end

#CHECK THIS OUT:
#ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }
#puts ARGV.join('-') -> takes argument from command line
#ARGV.each {|argv| puts argv}