require_relative 'lib/bst'

puts '----- Test start -----'
test_array = Array.new(15) { rand(1..100) }
tree = Tree.new
tree.build_tree(test_array)
p tree.balanced?
tree.pretty_print


tree.level_order { |n| print "#{n.data} "}
puts
tree.inorder { |n| print "#{n.data} " }
puts
tree.preorder { |n| print "#{n.data} " }
puts
tree.postorder { |n| print "#{n.data} " }
puts

5.times { tree.insert(rand(1..100)) }
p tree.balanced?
tree.pretty_print

tree.rebalance
p tree.balanced?
tree.pretty_print

tree.level_order { |n| print "#{n.data} " }
puts
tree.inorder { |n| print "#{n.data} " }
puts
tree.preorder { |n| print "#{n.data} " }
puts
tree.postorder { |n| print "#{n.data} " }
puts
puts '---- Test end -----'
