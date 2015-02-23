require 'spec_helper'

describe Book do
    before :each do
        @book = Book.new("title", "author", :category)
    end
    
    #hash refers to a method that can be called on an instance and will test it
    describe "#new" do
        it "returns a new book object" do
            @book.should(be_an_instance_of(Book))
        end
        
        it "throws an ArgumentError when given wrong number of params" do
##            because this is the wrong number of params, will not return a Book obj at all, but only an error, so the test should_not will not run
#            book = Book.new "Title", "author"
#            book.should_not(be_an_instance_of(Book))
            
            lambda{Book.new "title", "author"}.should(raise_exception(ArgumentError))
        end
        
    end
    
    describe "#title" do

##        same effect as ==
#        it "returns the correct title" do
#            @book.title.should(eql("title"))
#        end
        
        it "returns the correct title" do
            @book.title.should == "title"
        end
        
##        this test will not work because the equal function checks for same object in memory. Strings however, are created new objects every time
#        it "returns the correct title" do
#            @book.title.should(equal("title"))
#        end
    end
    
    describe "#author" do
        it "returns the correct author" do
            @book.author.should == "author"
        end
    end
    describe "#category" do
        it "returns the correct author" do
            @book.category.should == :category
        end
    end
    
end