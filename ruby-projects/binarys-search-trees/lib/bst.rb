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
    return node if node.nil?

    # Check if node is to be deleted
    if data < node.data
      node.left = delete(data, node.left)
    elsif data > node.data
      node.right = delete(data, node.right)
    else
      # No child to the left
      return node.right if node.left.nil?
      # No child to the right
      return node.left if node.right.nil?

      # Both children
      succ = get_successor(node.right)
      node.data = succ.data
      node.right = delete(succ.data, node.right)
    end
    node
  end

  def find(data, node = root)
    return node if node.nil?
    return node if node.data == data

    find(data, data < node.data ? node.left : node.right)
  end

  def level_order(mode = 'i', q = Queue.new.push(root), arr = Array.new, &block)
    # Runs the function iteratively
    if mode == 'i'
      loop do
        break if q.empty?

        if block_given?
          yield node = q.pop
        else
          node = q.pop
          arr.append(node.data)
        end
        q.push(node.left) unless node.left.nil?
        q.push(node.right) unless node.right.nil?
      end
      arr
    # Runs the function recursively
    elsif mode == 'r'
      return arr if q.empty?

      if block_given?
        yield node = q.pop
      else
        node = q.pop
        arr.append(node.data)
      end
      q.push(node.left) unless node.left.nil?
      q.push(node.right) unless node.right.nil?
      level_order('r', q, arr, &block)
    else
      'Invalid mode'
    end
  end

  def inorder(node = root, &block)
    return yield node unless node.children?

    inorder(node.left, &block) unless node.left.nil?
    yield node
    inorder(node.right, &block) unless node.right.nil?
  end

  def preorder(node = root, &block)
    return yield node unless node.children?

    yield node
    preorder(node.left, &block) unless node.left.nil?
    preorder(node.right, &block) unless node.right.nil?
  end

  def postorder(node = root, &block)
    return yield node unless node.children?

    postorder(node.left, &block) unless node.left.nil?
    postorder(node.right, &block) unless node.right.nil?
    yield node
  end

  def height(node = root)
    return 0 if node.nil? || !node.children?

    left_height = height(node.left)
    right_height = height(node.right)
    [left_height, right_height].max + 1
  end

  def depth(find_node = root, node = root, counter = 0)
    return 0 if node.nil?
    return counter if node == find_node

    left_depth = depth(find_node, node.left, counter + 1)
    right_depth = depth(find_node, node.right, counter + 1)
    [left_depth, right_depth].max
  end

  def balanced?(node = root)
    return true if node.nil? || !node.children?
    return false if (height(node.left) - height(node.right)).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    build_tree(level_order)
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

