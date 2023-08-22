class Move_explorer

  def valid_move?(board, start_pos, end_pos)
    return explore_path(board, start_pos, end_pos) if check_destination(board, start_pos, end_pos)
  end

  def explore_path(board, start_pos, end_pos)
    translation = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]
    return explore_straight(board, start_pos, translation) if translation[0].zero? || translation [1].zero?

    explore_diagonally(board, start_pos, translation)
  end

  def explore_diagonally(board, start_pos, translation)
    if translation[0].positive?
      explore_diagonally_down(board, start_pos, translation)
    else
      explore_diagonally_up(board, start_pos, translation)
    end
  end

  def explore_diagonally_down(board, start_pos, translation)
    if translation[1].positive?
      # explore to the right
      (translation[0] - 1).times do |pos|
        pos += 1
        return false unless board[start_pos[0] + pos][start_pos[1] + pos].nil?
      end
    else
      # explore to the left
      (translation[0] - 1).times do |pos|
        pos += 1
        return false unless board[start_pos[0] + pos][start_pos[1] - pos].nil?
      end
    end
  end

  def explore_diagonally_up(board, start_pos, translation)
    if translation[1].positive?
      # explore to the right
      (translation[0].abs - 1).times do |pos|
        pos += 1
        return false unless board[start_pos[0] - pos][start_pos[1] + pos].nil?
      end
    else
      # explore to the left
      (translation[0].abs - 1).times do |pos|
        pos += 1
        return false unless board[start_pos[0] - pos][start_pos[1] - pos].nil?
      end
    end
  end

  def explore_straight(board, start_pos, translation)
    if translation[0].zero?
      explore_horizontally(board, start_pos, translation)
    else
      explore_vertically(board, start_pos, translation)
    end
  end

  def explore_horizontally(board, start_pos, translation)
    if translation[1].positive?
      # explore to the right
      (translation[1] - 1).times { |pos| return false unless board[start_pos[0]][start_pos[1] + pos + 1].nil? }
    else
      # explore to the left
      (translation[1].abs - 1).times { |pos| return false unless board[start_pos[0]][start_pos [1] - (pos + 1)].nil? }
    end
  end

  def explore_vertically(board, start_pos, translation)
    if translation[0].positive?
      # explore down
      (translation[0] - 1).times { |pos| return false unless board[start_pos[0] + pos + 1][start_pos[1]].nil? }
    else
      # explore up
      (translation[0].abs - 1).times { |pos| return false unless board[start_pos[0] - (pos + 1)][start_pos[1]].nil? }
    end
  end

  def check_destination(board, start_pos, end_pos)
    current_piece = board[start_pos[0]][start_pos[1]]
    destination_piece = board[end_pos[0]][end_pos[1]]
    return true if destination_piece.nil?
    return nil if current_piece.white? == destination_piece.white?

    true
  end
end
