require_relative './caesar_cipher'

describe "Caesar Cipher" do
    
    let(:cipher) {caesar_cipher}
    
    describe "caesar_cipher" do
        it "shifts letters above z" do
            expect(caesar_cipher("yellow", 5)).to eql "djqqtb"
        end
        it "shifts letters below a" do
            expect(caesar_cipher("ale", -8)).to eql "sdw"
        end
        it "shifts letters between a and z" do
            expect(caesar_cipher("bait", 3)).to eql "edlw"
        end
    end
end