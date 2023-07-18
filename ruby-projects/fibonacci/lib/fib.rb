def fibs (input)
  if input < 1
    0
  elsif input == 1
    [0]
  elsif input == 2
    [0, 1]
  else
    input -= 2
    fib = [0, 1]
    input.times do |index|
      fib.append(fib[index] + fib[index + 1])
    end
    fib
  end
end

p fibs(10)

def fibs_rec(index)
  return [0, 1] if index == 1

  fib = fibs_rec(index - 1)
  fib.append(fib[index - 1] + fib[index - 2])
end

p fibs_rec(10)
