module ViewHelper
  def upcase_nine_letters(word)
    word.upcase.split('')[0..8]
  end

  def cell_for(x, y)
    content_tag(:td, :class => "cell", :id => "cell_#{x}x#{y}") do
      if letter = @game.find_cell_letter(x, y)
        render partial: 'games/tile', locals: {letter: letter, value: Tile.find_by_letter(letter.upcase).value, active: false}
      end
    end
  end
end
