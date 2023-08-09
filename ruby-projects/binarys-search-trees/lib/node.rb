class  Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize (data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def children?
    return false if self.left.nil? && self.right.nil?

    true
  end

  def one_child?
    return false if self.left.nil? ^ self.right.nil?
  end

end

module Comparable
  def <=>(other)
    self.data <=> other.data
  end
end




