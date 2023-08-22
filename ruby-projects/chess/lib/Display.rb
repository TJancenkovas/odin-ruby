class Display
  #used to display the chess-board

  attr_reader :size

  def initialize(size = 8)
    @size = size
  end

  def print_board(board)
    puts_letters
    puts_line
    size.times do |row|
      puts_row(board, row)
    end
  end

  def print_piece(board, row, col)
    if board[row][col].nil?
      piece = ' '
    else
      piece = board[row][col]
    end
    print " #{piece} |"
  end

  def puts_row(board, row)
    print "#{row}|"
    size.times { |col| print_piece(board, row, col) }
    puts
    puts_line
  end

  def puts_line
    print(' ')
    (size * 4 + 1).times { print('-') }
    puts
  end

  def puts_letters
    print '  '
    size.times { |n| print(" #{(65 + n).chr}  ")}
    puts
  end
end
