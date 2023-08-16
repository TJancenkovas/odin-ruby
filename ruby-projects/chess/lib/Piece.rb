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
end
