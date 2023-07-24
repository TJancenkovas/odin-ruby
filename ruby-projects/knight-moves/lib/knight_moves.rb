BOARD_SIZE = 8

class Node
  MOVE_PATTERN = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]].freeze
  @@visited = []
  attr_accessor :data, :parent

  def initialize(data, parent = nil)
    @data = data
    @parent = parent
    @@visited.push(data)
  end

  def children
    MOVE_PATTERN.map { |move| [data[0] + move[0], data[1] + move[1]] }
                .keep_if { |child| on_board?(child) }
                .reject { |child| @@visited.include?(child) }
                .map { |child| Node.new(child, self) }
  end

  def on_board?(pos)
    pos[0].between?(1, BOARD_SIZE) && pos[1].between?(1, BOARD_SIZE)
  end

  def to_root(node)
    return [node.data] if node.parent.nil?

    to_root(node.parent).append(node.data)
  end
end

def knight_moves(start, finish)
  q = Queue.new
  node = Node.new(start)
  loop do
    return node.to_root(node) if node.data == finish

    node.children.each { |child| q.push(child)}
    node = q.pop
  end
end

p knight_moves([1, 1], [3, 2])
p knight_moves([4, 4], [7, 8])
