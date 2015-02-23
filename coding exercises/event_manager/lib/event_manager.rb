require "csv"
require "sunlight/congress"
require "erb"
puts "EventManager Initialized!"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

## Read lines using File
#lines = File.readlines "./lib/event_attendees.csv"
#lines.each_with_index do |line, index|
#    next if index == 0
#    columns = line.split(",")
#    puts columns[2]
#end



def clean_zipcode(zipcode)
#    if zipcode.nil?
#        zipcode = "00000"
#    elsif zipcode.length < 5
#        zipcode = zipcode.rjust(5, "0")
#    elsif zipcode.length > 5
#        zipcode = zipcode[0..4]
#    end
    zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
    Sunlight::Congress::Legislator.by_zipcode(zipcode)
#    legislator_names = legislators.collect do |legislator|
#        "#{legislator.first_name} #{legislator.last_name}"
#    end
#    
#    legislators_string = legislator_names.join(", ")
end

def save_thank_you_letters(id, form_letter)
    Dir.mkdir("output") unless Dir.exists?("output")
    
    filename = "output/thanks_#{id}.html"
    
    File.open(filename, 'w') do |file|
        file.puts form_letter
    end
end

template_letter = File.read "./form_letter.erb"
erb_template = ERB.new(template_letter)
contents = CSV.open "./event_attendees.csv", headers: true, header_converters: :symbol

contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    
    legislators = legislators_by_zipcode(zipcode)
    
    form_letter = erb_template.result(binding)
    
    save_thank_you_letters(id, form_letter)
    
end