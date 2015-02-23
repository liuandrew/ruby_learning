#CONVENTION: write in present tense (the it statements)

require 'spec_helper'

describe "Library Object" do
    
    #does this once
    before :all do
        lib_arr = [
            Book.new("Javascript", "Crockford", :development), 
            Book.new("Web Standards", "Zeldman", :design), 
            Book.new("Think", "Krug", :usability), 
            Book.new("Javascript Patterns", "Stefanov", :development), 
            Book.new("Responsive Web Design", "Marcotte", :design), 
        ]
        
        File.open("books.yml", "w") do |f|
            f.write YAML::dump lib_arr
        end
        
    end
    
    #before each test
    before :each do
        @lib = Libary.new("books.yml")
    end
    
    describe "#new" do
        context "with no parameters" do
            it "has no books" do
                lib = Library.new
                expect lib.books.length == 0 # lib.books.length.should == 0
            end
        end
        
        context "with a yaml file name parameter" do 
            it "has five books" do 
                @lib.should(have(5).books)
            end
        end
    end
    
    it "returns all the books in a given category" do
        @lib.get_books_in_category(:development).length.should == 2
    end
    
    it "accepts new books" do
        @lib.add_book(Book.new("Designing for Web", "Boulton", :desing))
        @lib.get_book("Designing for Web").should(be_an_instance_of(Book))
    end
    
    it "saves a library" do
        books = @lib.books.map {|book| book.title}
        @lib.save "new_library.yml"
        lib2 = Library.new "new_library.yml"
        books2 = lib2.books.map {|book| book.title}
        books.should eql books2
    end
end