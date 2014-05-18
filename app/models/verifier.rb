class Verifier
	attr_reader :word_array, :invalid_words
	def initialize(word_string)
		@word_array = word_string.upcase.split("-")
           @invalid_words = Array.new
	end

	# def valid?
	# 	word_array.all?{ |word| Word.where(text: word).any? }
 #    end

  # evaluate each word passed in as true or false and return invalid words
    def valid?
      @word_array.each do |word|
        if Word.where(text: word).any? != true
        @invalid_words << word
        end
      end
      return true if @invalid_words.length == 0 
      false
    end
end