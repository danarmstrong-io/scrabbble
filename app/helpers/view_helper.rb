module ViewHelper
  def upcase_nine_letters(word)
    word.upcase.split('')[0..8]
  end

  def cell_for(x, y)
    content_tag(:td, :class => "cell #{find_cell_class(x, y)}", :id => "cell_#{x}x#{y}", :data => {:x => x, :y => y}) do
      if letter = @game.find_cell_letter(x, y)
        render partial: 'games/tile', locals: {letter: letter, value: Tile.find_by_letter(letter.upcase).value, active: false}
      end
    end
  end

  def find_cell_class(x, y)
    if x == 7 and y == 7
      return "center"
    end
    # TRIPLE WORDS
    if x % 7 == 0 && y % 7 == 0
      return "triple_word"
    end

    # TRIPLE LETTERS
    if (x == 5 || x == 9) && (y % 4 == 1) || (y == 5 || y == 9) && (x % 4 == 1)
      return "triple_letter"
    end


    # DOUBLE WORDS
    if x == y && (x < 5 || x > 9)
      return "double_word"
    end
    if (x - 14).abs == y && (x < 5 || x > 9)
      return "double_word"
    end

    # DOUBLE LETTERS
    if y % 7 == 0 && (x == 3 || x == 11) || x % 7 == 0 && (y == 3 || y == 11)
      return "double_letter"
    end

    if (y == 6 || y == 8) && (x == 2 || x == 6 || x == 8 || x == 12)
      return "double_letter"
    end

    if (x == 6 || x == 8) && (y == 2 || y == 6 || y == 8 || y == 12)
      return "double_letter"
    end
  end
end
