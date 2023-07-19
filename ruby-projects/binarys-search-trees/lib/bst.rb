# frozen_string_literal: true

require_relative 'node'

# A binary search tree
class Tree
  attr_accessor :root

  def initialize(root = nil)
    @root = root
  end

  def build_tree(arr)
    build(arr.uniq.sort)
  end

  def build(arr)
    return Node.new(arr[0]) if arr.length == 1
    return nil if arr.length == 0

    self.root = Node.new(
      arr[arr.length / 2],
      build_tree(split_left(arr)),
      build_tree(split_right(arr))
    )
  end

  def insert(data, node = root)
    return 'Data already exists' if data == node.data
    return node.left = Node.new(data) if node.left.nil? && data < node.data
    return node.right = Node.new(data) if node.right.nil? && data > node.data

    insert(data, data < node.data ? node.left : node.right)
  end

  def delete(data, node = root)
    return "No data found" if node.nil?
    # Check if node is to be deleted
    if node.data == data
      if data.two_children?
      else
        return
      end
    end

    #Continue looking
    delete(data, data < node.data ? node.left : node.right)
  end

  def get_successor(node)
    return node if node.left.nil?

    get_successor(node.left)
  end

  def split_left(arr)
    arr[...(arr.length / 2)]
  end

  def split_right(arr)
    arr[(arr.length / 2 + 1)...]
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new()
tree.build_tree(arr)
tree.insert(60)
p tree.pretty_print
