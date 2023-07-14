def merge_sort(arr)
  return arr if arr.length == 1

  merge(merge_sort(arr[...arr.length / 2]), merge_sort(arr[arr.length / 2..]))
end

def merge(arr1, arr2)
  arr_new = []
  loop do
    return arr_new.append(arr2).flatten if arr1.empty?
    return arr_new.append(arr1).flatten if arr2.empty?

    if arr1.first < arr2.first
      arr_new.append(arr1.shift)
    else
      arr_new.append(arr2.shift)
    end
  end
end

test_array = [2,8,5,4,1,3,6,7]
p merge_sort(test_array)

