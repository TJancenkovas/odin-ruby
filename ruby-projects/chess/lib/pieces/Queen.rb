require_relative "Piece"

class Queen < Piece
  attr_accessor :color, :moved, :symbol, :points_worth

  def initialize(color, board, start_pos)
    super(color, board, start_pos)
    @symbol = symbol?(color)
    @points_worth = 8
  end

  def valid_move?(start_pos, end_pos)
    translation = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]
    return nil if translation == [0, 0]
    return true if sideways?(translation) || up_down?(translation) || diagonal?(translation)
  end

  private

  def symbol?(color)
    return "♕" if color == 'white'
    return "♛" if color == 'black'

    nil
  end
end
