module Moves
  def diagonal
    [-1, 1].repeated_permutations.to_a.reject{ |arr| arr = [0, 0] }
  end
  def straight_and_sideways

  end
end
