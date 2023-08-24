require_relative "Piece"

class Pawn < Piece
  attr_accessor :color, :moved, :symbol, :points_worth

  def initialize(color, board, start_pos)
    super(color, board, start_pos)
    @symbol = symbol?(color)
    @moved = false
    @points_worth = 1
  end

  def valid_move?(start_pos, end_pos)
    translation = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]
    return true if valid_attack?(translation, end_pos)

    if moved?
      return true if white? && one_up?(translation)
      return true if !white? && one_down?(translation)
    else
      return true if white? && (one_up?(translation) || two_up?(translation))
      return true if !white? && (one_down?(translation) || two_down?(translation))
    end
  end

  def valid_attack?(translation, end_pos)
    return true if white? && (up_left?(translation) || up_right?(translation)) && opposing_piece(end_pos)
    return true if !white? && (down_left?(translation) || down_right?(translation)) && opposing_piece(end_pos)
  end

  def opposing_piece(end_pos)
    opposing_piece = board[end_pos[0]][end_pos[1]]
    return false if opposing_piece.nil? || opposing_piece.white? == white?

    true
  end

  private

  def symbol?(color)
    return "♙" if color == 'white'
    return "♟︎" if color == 'black'

    nil
  end

  def one_up?(translation)
    return true if translation == [-1, 0]
  end

  def two_up?(translation)
    return true if translation == [-2, 0]
  end

  def one_down?(translation)
    return true if translation == [1, 0]
  end

  def two_down?(translation)
    return true if translation == [2, 0]
  end

  def up_left?(translation)
    return true if translation == [-1, -1]
  end

  def up_right?(translation)
    return true if translation == [-1, 1]
  end

  def down_left?(translation)
    return true if translation == [1, -1]
  end

  def down_right?(translation)
    return true if translation == [1, 1]
  end
end
