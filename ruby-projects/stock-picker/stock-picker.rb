def stock_picker (stock_list)
   #Take first day stock
   list_length = stock_list.length
   max_gain = 0;
   best_days = [];
   stock_list.each_with_index do |stock_price, index|
    #Compare to upcoming day stocks and find the diff
    for next_index in (index + 1)...list_length
      if stock_list[next_index] - stock_price > max_gain
        max_gain = stock_list[next_index] - stock_price
        #Store highest diff pair
        best_days = [index, next_index]
      end
    end

  #Repeats process for all other days
   end
  best_days
end

puts stock_picker([17,3,6,9,15,8,6,12,1])
