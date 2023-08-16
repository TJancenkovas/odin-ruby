require_relative "Piece"

class Pawn < Piece
  attr_accessor :color, :moved, :symbol, :points_worth

  def initialize(color)
    super(color)
    @symbol = symbol?(color)
    @moved = false
    @points_worth = 1
  end

  def allowed_moves
    if moved?
      return [[1, 0]] if white?
      return [[-1, 0]] if black?
    else
      return [[1, 0], [2, 0]] if white?
      return [[-1, 0], [-2, 0]] if black?
    end
  end

  def allowed_attacks
    return [[1, 1], [1, -1]] if white?
    return [[-1, 1], [-1, -1]] if black?
  end

  private

  def symbol?(color)
    return "\u2659" if color == 'white'
    return "\u265f" if color == 'black'

    nil
  end
end
