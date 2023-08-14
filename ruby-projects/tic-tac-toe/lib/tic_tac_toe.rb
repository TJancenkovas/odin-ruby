require 'pry'
require 'matrix'

class Board

  def initialize(layout = [[1, 2, 3], [4, 5, 6], [7, 8, 9]])
     @layout = layout
  end

  def start(player1, player2)
    puts "\n\nGame start"
    draw
    while true
      if play(player1)
        winner(player1, player2)
        break
      end
      if play(player2)
        winner(player2, player1)
        break
      end
    end
  end

  def play(player)
    position = nil
    until position do
      puts "#{player.name} choose position:"
      position = gets.chomp.to_i
      position = Matrix[*@layout].index(position) #Get coords of element
    end
    @layout[position[0]][position[1]] = player.symbol #Change element to player symbol
    draw
    check(player)
  end

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
        if (i + 2 < rows && j + 2 < cols) && @layout[i][j] == symbol && @layout[i + 1][j + 1] == symbol && @layout[i + 2][j + 2] == symbol
          return true
        end

        #Check diagonal down-left
        if (j - 2 >= 0 && i + 2 < rows) && @layout[i][j] == symbol && @layout[i + 1][j - 1] == symbol && @layout[i + 2][j - 2] == symbol #You can simplyfy here
          return true
        end

      end
    end
    return false
  end

  def winner(player_win, player_loose)
    puts "Congratulations #{player_win.name} won!"
    puts 'Play again? (Y/N)'
    if gets.chomp == 'Y'
      start(player_loose,player_win)
    end
  end
end

class Player

  attr_reader :name, :symbol

  def initialize(name, symbol)
     @name = name
     @symbol = symbol
  end

end


# print 'Enter Player 1: '
# player1 = Player.new(gets.chomp, 'x')

# print 'Enter Player 2: '
# player2 = Player.new(gets.chomp, 'o')

# board = Board.new()

# board.start(player1, player2)
