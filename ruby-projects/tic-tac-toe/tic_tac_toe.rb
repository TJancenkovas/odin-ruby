#Classes
  #Player
require 'matrix'

class Board

  def initialize(layout = [[1, 2, 3], [4, 5, 6], [7, 8, 9]])
     @layout = layout
  end

  def prepare
    draw
  end

  def play(player, position)
    position = Matrix[*@layout].index(position) #Get coords of element
    @layout[position[0]][position[1]] = player.symbol #Change element to player symbol
    draw
    puts check(player)
  end

  #private

  def draw
    @layout.each_with_index do |row, row_index|
      row.each_with_index do |el, el_index|
        print " #{el} "
        print "|" if el_index < row.length-1
      end
      if row_index < @layout.length-1
        puts
        row.each_with_index do |el, el_index|
          print "---"
          print "+" if el_index < row.length-1
        end
        puts
      end
    end
    puts
  end

  def check(player)
    rows = @layout.length
    cols = @layout[0].length
    symbol = player.symbol

    (0...rows).each do |i|
      (0...cols).each do |j|

        #Check right
        if j + 2 < cols && @layout[i][j] == symbol && @layout[i][j + 1] == symbol && @layout[i][j + 2] == symbol
          return true
        end

        #Check down
        if i + 2 < rows && @layout[i][j] == symbol && @layout[i + 1][j] == symbol && @layout[i+ 2 ][j] == symbol
          return true
        end

          #Check diagonal down-right
        if i + 2 < cols && @layout[i][j] == symbol && @layout[i + 1][j + 1] == symbol && @layout[i + 2][j + 2] == symbol
          return true
        end

        #Check diagonal down-left
        if j - 2 >= 0 && @layout[i][j] == symbol && @layout[i + 1][j - 1] == symbol && @layout[i + 2][j - 2] == symbol
          return true
        end

      end
    end
    return false
  end
end

class Player

  attr_reader :name, :symbol

  def initialize(name, symbol)
     @name = name
     @symbol = symbol
  end

end


player1 = Player.new('1', 'x')

board = Board.new()
board.play(player1, 3)
board.play(player1, 5)
board.play(player1, 7)

