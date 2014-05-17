module ViewHelper
  def upcase_nine_letters(word)
    word.upcase.split('')[0..8  ]
  end
end