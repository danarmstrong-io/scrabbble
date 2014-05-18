class Verifier
	attr_reader :word_array
	def initialize(word_string)
		@word_array = word_string.upcase.split("-")
	end

	def valid?
		word_array.all?{ |word| Word.where(text: word).any? }
  end
end