class Calculator

  def add(*args)
    args.flatten!
    return args[0] + args[1] if args[2..].empty?

    args[0] + add(args[1..])
  end

  def multiply(*args)
    args.flatten!
    return args[0] * args[1] if args[2..].empty?

    args[0] * multiply(args[1..])
  end

  def subtract(*args)
    args[0] - args[1]
  end

  def divide(*args)
    args[0] / args[1]
  end
end


p Calculator.new.add(1, 2, 3, 4, 4)
