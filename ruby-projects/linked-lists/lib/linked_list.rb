class LinkedList
  attr_accessor :head, :tail

  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  def append(value)
    return start_list(value) if head.nil?

    tail.next_node = create_node(value)
    self.tail = tail.next_node
  end

  def prepend(value)
    return start_list(value) if head.nil?

    self.head = create_node(value, head)
  end

  def create_node(value = nil, next_node = nil)
    Node.new(value, next_node)
  end

  def start_list(value)
    self.head = create_node(value)
    self.tail = head
  end

  def size(node = head, counter = 1)
    return counter if node.next_node.nil?

    size(node.next_node, counter + 1)
  end

  def at(index, node = head, counter = 0)
    return node if index == counter
    return 'Node not found' if node.next_node.nil?

    at(index, node.next_node, counter + 1)
  end

  def pop(node = head)
    return node.next_node = nil if node.next_node.next_node.nil?

    pop(node.next_node)
  end

  def contains?(value, node = head)
    return true if node.value == value
    return false if node.next_node.nil?

    contains?(value, node.next_node)
  end

  def find(value, node = head, counter = 0)
    return counter if node.value == value
    return nil if node.next_node.nil?

    find(value, node.next_node, counter + 1)
  end

  def to_s(node = head)
    return "( #{node.value} ) -> ( nil )" if node.next_node.nil?

    "( #{node.value} ) -> " + to_s(node.next_node)
  end

  def insert_at(value, index, node = head, counter = 1)
    return node.next_node = create_node(value, node.next_node) if counter == index
    return nil if node.next_node.nil?

    insert_at(value, index, node.next_node, counter + 1)
  end

  def remove_at(index, node = head, counter = 1)
    return node.next_node = node.next_node.next_node if counter == index

    remove_at(index, node.next_node, counter + 1)
  end

end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

ll = LinkedList.new()
p ll
ll.append(4)
ll.append(5)
ll.append(3)
ll.prepend(1)
p ll.pop
p ll.size
p ll.head
p ll.at(2)
p ll.contains?(5)
p ll.contains?(6)
p ll.find(5)
p ll.find(6)
p ll.to_s
p ll.insert_at(0, 1)
p ll.to_s
p ll.remove_at(1)
p ll.to_s
