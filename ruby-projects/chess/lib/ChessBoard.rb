require_relative 'pieces/Pawn'
require_relative 'pieces/Bishop'
require_relative 'pieces/Rook'
require_relative 'pieces/Queen'
require_relative 'pieces/King'
require_relative 'pieces/Knight'
require_relative 'Display'
require_relative 'Move_explorer'

class ChessBoard

  attr_accessor :board, :size

  def initialize
    @board = []
    @size = 8
    @display = Display.new
  end

  def new_board
    self.board = empty_array(size)
    add_pawns(board)
    add_major_pieces(board)
    board.flatten.reject(&:nil?).each(&:update_legal_moves)
  end

  def print_board
    @display.print_board(board)
  end

  def move_piece(start_pos, end_pos)
    piece = board[start_pos[0]][start_pos[1]]
    if piece.legal_move?(end_pos)
      take_piece(piece, start_pos, end_pos)
      update_all_piece_moves
      puts check?('white')
      puts check?('black')
    else
      false
    end
  end

  def take_piece(piece, start_pos, end_pos)
    taken_piece = board[end_pos[0]][end_pos[1]]
    game_over if taken_piece.instance_of?(::King)
    board[end_pos[0]][end_pos[1]] = piece
    board[start_pos[0]][start_pos[1]] = nil
    piece.moved = true
    piece.current_pos = end_pos
    piece
  end

  def game_over
    exit
  end

  def check?(color)
    king_pos = board.flatten.find { |piece| piece.instance_of?(::King) && piece.color == color }.current_pos
    opp_pieces = pieces.reject { |piece| piece.color == color}

    opp_pieces.each do |piece|
      return "#{color} king in check" if piece.move_list.include?(king_pos)
    end
    false
  end

  def pieces
    board.flatten.reject(&:nil?)
  end

  private

  def update_all_piece_moves
    pieces.each(&:update_legal_moves)
  end

  def add_pawns(board)
    board[6] = board[6].each_with_index.map { |_, index| Pawn.new('white', board, [6, index]) }
    board[1] = board[1].each_with_index.map { |_, index| Pawn.new('black', board, [1, index]) }
  end

  def add_major_pieces(board)
    add_rooks(board)
    add_knights(board)
    add_bishops(board)
    add_queens(board)
    add_kings(board)
  end

  def empty_array(size)
    new_board = Array.new(size)
    new_board.map! { |el| el = Array.new(size) }
  end

  def add_rooks(board)
    board[0][0] = Rook.new('black', board, [0, 0])
    board[0][7] = Rook.new('black', board, [0, 7])
    board[7][0] = Rook.new('white', board, [7, 0])
    board[7][7] = Rook.new('white', board, [7, 7])
  end

  def add_knights(board)
    board[0][1] = Knight.new('black', board, [0, 1])
    board[0][6] = Knight.new('black', board, [0, 6])
    board[7][1] = Knight.new('white', board, [7, 1])
    board[7][6] = Knight.new('white', board, [7, 6])
  end

  def add_bishops(board)
    board[0][2] = Bishop.new('black', board, [0, 2])
    board[0][5] = Bishop.new('black', board, [0, 5])
    board[7][2] = Bishop.new('white', board, [7, 2])
    board[7][5] = Bishop.new('white', board, [7, 5])
  end

  def add_queens(board)
    board[0][3] = Queen.new('black', board, [0, 3])
    board[7][3] = Queen.new('white', board, [7, 3])
  end

  def add_kings(board)
    board[0][4] = King.new('black', board, [0, 4])
    board[7][4] = King.new('white', board, [7, 4])
  end
end

board = ChessBoard.new
board.new_board
board.print_board
board.move_piece([6, 5], [4, 5])


board.move_piece([0, 2], [4, 2])
board.move_piece([1, 4], [3, 4])
# board.board[1][2] = Bishop.new('white', board, [1, 2])
board.print_board
board.move_piece([4, 5], [3, 4])
board.move_piece([3, 4], [2, 4])
board.move_piece([2, 4], [1, 4])
board.print_board
