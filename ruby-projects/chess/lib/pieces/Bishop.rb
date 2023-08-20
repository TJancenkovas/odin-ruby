require_relative "Piece"

class Bishop < Piece
  attr_accessor :color, :moved, :symbol, :points_worth

  def initialize(color)
    super(color)
    @symbol = symbol?(color)
    @points_worth = 3
  end

  def valid_move?(start_pos, end_pos)
    translation = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]
    return nil if translation == [0, 0]
    return true if diagonal?(translation)

  end

  private

  def symbol?(color)
    return "♗" if color == 'white'
    return "♝" if color == 'black'

    nil
  end
end
