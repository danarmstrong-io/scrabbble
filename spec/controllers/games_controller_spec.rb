require 'spec_helper'

# CODE REVIEW: how is this a controller test? What is this testing? This seems
# like a concern that belongs in a class somewhere
feature 'validating words' do
  describe '#match' do
    it 'returns true if all checked words are valid' do
      valid_string = "word-dog-cat"
      expect(valid_string.split('-').all? { |word| !(Word.where(text: word)).empty? }).to eq true
    end

    it 'returns false if any checked word is invalid' do
      invalid_string = "word-eeaaiioomfr-cat-foundation"
      expect(invalid_string.split('-').all? { |word| !(Word.where(text: word)).empty? }).to eq false
    end
  end
end