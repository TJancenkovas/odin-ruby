class Piece
  attr_accessor :color, :moved, :explorer, :board, :current_pos, :move_list

  def initialize(color, board, start_pos)
    @color = color
    @board = board
    @moved = false
    @explorer = Move_explorer.new
    @current_pos = start_pos
    @move_list = []
  end

  def legal_move?(end_pos)
    return true if move_list.include? end_pos

    nil
  end

  def update_legal_moves
    self.move_list = []
    8.times do |row|
      8.times do |col|
        self.move_list.append([row, col]) if legal?(current_pos, [row, col])
      end
    end
  end

  def legal?(start_pos, end_pos)
    return false unless valid_move?(start_pos, end_pos) && explorer.check_destination(board, start_pos, end_pos)
    return explorer.explore_path(board, start_pos, end_pos) unless instance_of?(::Knight)

    true
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
