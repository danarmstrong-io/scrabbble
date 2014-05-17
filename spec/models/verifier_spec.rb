require 'spec_helper'

feature 'Validator' do
	before :each do
    Word.create!(text: "WORD")
    Word.create!(text: "DOG")
    Word.create!(text: "CAT")
	end

	describe 'Verifier initialize' do
		it "accepts a string and returns an array of capitalized words" do
			words = Verifier.new("word-dog-cat")
			expect(words.word_array).to eq(["WORD", "DOG", "CAT"])
		end
	end

	describe "valid" do
		it "returns true if all checked words are valid" do
			valid_string = Verifier.new("word-dog-cat")
			expect(valid_string.valid?).to eq true
		end
	
		it "returns false if all checked words are invalid" do
			invalid_string = Verifier.new("word-dog-sadvdava-cat")
			expect(invalid_string.valid?).to eq false
		end
	end
end