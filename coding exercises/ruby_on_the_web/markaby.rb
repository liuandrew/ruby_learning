require 'rubygems'
require 'markaby'

m = Markaby::Builder.new

m.html do
    head {title 'This is the title' }
    
    body do
        h1 'Hello world'
        h2 'Sub-heading'
        p %q{This is a piel aefoils}
        h2 'Another sub-heading'
        p 'Markaby is goda t'
        ul do
            li 'Generating HTML from Ruby'
            li 'Keping HTML struscute'
            li 'Lots more...'
        end
    end
end

puts m