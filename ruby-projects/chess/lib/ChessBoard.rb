require_relative 'pieces/Pawn'
require_relative 'pieces/Bishop'
require_relative 'pieces/Rook'
require_relative 'pieces/Queen'
require_relative 'pieces/King'
require_relative 'pieces/Knight'
require_relative 'Display'

class ChessBoard

  attr_accessor :board, :size

  def initialize
    @board = []
    @size = 8
    @display = Display.new
  end

  def new_board
    self.board = empty_array(size)
    self.board = add_pawns(board)
    self.board = add_major_pieces(board)
  end

  def print_board
    @display.print_board(board)
  end

  def move_piece(start_pos, end_pos)
    piece = board[start_pos[0]][start_pos[1]]
    return false unless piece.valid_move?(start_pos, end_pos)

    board[end_pos[0]][end_pos[1]] = piece
    board[start_pos[0]][start_pos[1]] = nil
    piece
  end

  private

  def add_pawns(board)
    board[6].map! { Pawn.new('white') }
    board[1].map! { Pawn.new('black') }
    board
  end

  def add_major_pieces(board)
    board = add_rooks(board)
    board = add_knights(board)
    board = add_bishops(board)
    board = add_queens(board)
    board = add_kings(board)
  end

  def empty_array(size)
    new_board = Array.new(size)
    new_board.map! { |el| el = Array.new(size) }
  end

  def add_rooks(board)
    board[0][0] = Rook.new('black')
    board[0][7] = Rook.new('black')
    board[7][0] = Rook.new('white')
    board[7][7] = Rook.new('white')
    board
  end

  def add_knights(board)
    board[0][1] = Knight.new('black')
    board[0][6] = Knight.new('black')
    board[7][1] = Knight.new('white')
    board[7][6] = Knight.new('white')
    board
  end

  def add_bishops(board)
    board[0][2] = Bishop.new('black')
    board[0][5] = Bishop.new('black')
    board[7][2] = Bishop.new('white')
    board[7][5] = Bishop.new('white')
    board
  end

  def add_queens(board)
    board[0][3] = Queen.new('black')
    board[7][3] = Queen.new('white')
    board
  end

  def add_kings(board)
    board[0][4] = King.new('black')
    board[7][4] = King.new('white')
    board
  end
end

board = ChessBoard.new
board.new_board
board.print_board
board.move_piece([6, 4], [4, 4])
board.move_piece([0, 2], [4, 2])
board.print_board
