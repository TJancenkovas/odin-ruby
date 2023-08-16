class Board
  require_relative 'player'

  attr_accessor :layout
  attr_reader :height, :width

  def initialize(width = 7, height = 6)
    @width = width
    @height = height
    @layout = build_board(width, height)
  end

  def start(name1 = 'P1', name2 = 'P2')
    p1 = Player.new(name1, 'red')
    p2 = Player.new(name2, 'black')
    loop do
      print_board
      play(p1)
      print_board
      play(p2)
    end

  end

  def play(player)
    puts "#{player.name}'s turn, choose location to drop:"
    choice = gets_choice
    drop_token(player, choice)
    if check_winner(player)
      puts "Game over! #{player.name} won!"
      exit
    end
  end

  def build_board(w, h)
    layout = []
    w.times do
      layout.append(Array.new(h) { "\u2B55" })
    end
    layout
  end

  def drop_token(player, pos)
    bottom = height - 1
    loop do
      return nil if bottom.negative?
      return layout[pos][bottom] = player.symbol if layout[pos][bottom] == "\u2B55"

      bottom -= 1
    end
  end

  def check_winner(player)
    symbol = player.symbol
    height.times do |x|
      width.times do |y|
        return player if layout[x][y] == symbol && won?(symbol, x, y)
      end
    end
    false
  end

  def won?(symbol, x, y)
    return true if check_down(symbol, x, y)
    return true if check_right(symbol, x, y)
    return true if check_diagonal_left(symbol, x, y)
    return true if check_diagonal_right(symbol, x, y)

    false
  end

  def check_down(symbol, pos_x, pos_y)
    # pos_x →
    # pos_y ↓
    # Out of bounds check
    return false if pos_y + 4 > height

    3.times do |n|
      n += 1
      return false unless layout[pos_x][pos_y + n] == symbol
    end
    true
  end

  def check_right(symbol, pos_x, pos_y)
    # pos_x →
    # pos_y ↓
    # Out of bounds check
    return false if pos_x + 4 > width

    3.times do |n|
      n += 1
      return false unless layout[pos_x + n][pos_y] == symbol
    end
    true
  end

  def check_diagonal_right(symbol, pos_x, pos_y)
    # pos_x →
    # pos_y ↓
    # Out of bounds check
    return false if pos_x + 4 > width || pos_y + 4 > height

    3.times do |n|
      n += 1
      return false unless layout[pos_x + n][pos_y + n] == symbol
    end
    true
  end

  def check_diagonal_left(symbol, pos_x, pos_y)
    # pos_x →
    # pos_y ↓
    # Out of bounds check
    return false if (pos_x - 3).negative? || (pos_y + 4) > height

    3.times do |n|
      n += 1
      return false unless layout[pos_x - n][pos_y + n] == symbol
    end
    true
  end

  def print_board
    width.times do |n|
      print "#{n+1}  "
    end
    puts
    puts board_to_string
  end

  def board_to_string
    board_string = ''
    height.times do |y|
      width.times do |x|
        board_string << "#{layout[x][y]} "
      end
      board_string << "\n"
    end
    board_string
  end

  def gets_choice
    loop do
      choice = gets.chomp
      return Integer(choice) - 1 if valid_input?(choice)
    end
  end

  def valid_input?(input)
    return false unless (Integer(input) rescue false)
    input = Integer(input) - 1
    return false if input.negative? || input >= width || layout[input][0] != "\u2B55"

    true
  end
end
