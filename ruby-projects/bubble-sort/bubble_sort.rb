def bubble_sort (array)
  sorted = false
    until sorted
      sorted = true
      for index in 0...array.length-1
        if array[index] > array[index+1]
          array[index], array[index+1] = array[index+1], array[index]
          sorted = false
        end
      end
    end
  array
end

puts bubble_sort([4,3,78,2,0,2])
