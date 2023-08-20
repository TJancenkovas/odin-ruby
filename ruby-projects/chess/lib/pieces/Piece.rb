class Piece
  attr_accessor :color, :moved

  def initialize(color)
    @color = color
    @moved = false
  end

  def moved?
    moved == true
  end

  def white?
    color == 'white'
  end

  def black?
    color == 'black'
  end

  def to_s
    symbol
  end
  # Common move evaluations

  def sideways?(translation)
    return true if translation[0].zero?
  end

  def up_down?(translation)
    return true if translation[1].zero?
  end

  def diagonal?(translation)
    return nil if  translation[0] == 0 || translation[1] == 0
    return true if translation[0].abs / translation[1].abs == 1
  end
end
