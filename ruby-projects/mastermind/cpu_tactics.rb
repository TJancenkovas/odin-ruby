def cpu_guess(slot, number)
  s_set = make_code_set(slots, numbers)

end

def make_code_set(slots, numbers)
  set = []
  numbers.times { |n| set.append(n) }
  set.repeated_permutation(slots).to_a
end

def remove_same_response
  # Placeholder
end
