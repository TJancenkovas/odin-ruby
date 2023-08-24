require_relative "Piece"

class King < Piece
  attr_accessor :color, :moved, :symbol, :points_worth, :allowed_translations

  def initialize(color, board, start_pos)
    super(color, board, start_pos)
    @symbol = symbol?(color)
    @points_worth = 8
    @allowed_translations = [-1, 0, 1].repeated_permutation(2).to_a.reject { |el| el == [0,0] }
  end

  def valid_move?(start_pos, end_pos)
    translation = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]
    return nil if translation == [0, 0]
    return true if one_any_direction?(translation)
  end

  private

  def symbol?(color)
    return "♔" if color == 'white'
    return "♚" if color == 'black'

    nil
  end

  def one_any_direction?(translation)
    allowed_translations.each do |el|
      return true if el == translation
    end
    false
  end
end
