
class Mastermind
  attr_reader :numbers, :slots

  def initialize (slots, numbers)
    @slots = slots
    @numbers = numbers
  end

  def play
    code = make_code
    p code
    puts 'Code generated'

    12.times do |n|
      guess = get_guess(n)
      p guess
      if guess == code
        win
        exit
      else
         print_accuracy(guess, code)
      end
    end
    loose
  end

  private

  def make_code
    rnd = Random.new()

    code = Array.new(slots)
    code.map! do |el|
      el = rnd.rand(numbers)
    end
  end

  def get_guess(n)
    puts "Enter guess number #{n+1}:"
    loop do
      guess = gets.chomp.split(' ')
      if guess.length == slots
        return guess.map { |el| el.to_i}
      else
        puts "Guess length must be #{slots}"
      end
    end
  end

  def print_accuracy(guess, code)
    temp_guess = Array.new()
    temp_code = Array.new()
    slots.times do |n|
      if guess[n] == code[n]
        print 'E '
      else
        temp_guess.append(guess[n])
        temp_code.append(code[n])
      end
    end
    temp_guess.each do |el|
      if temp_code.include?(el)
        print 'P '
        temp_code.delete_at(temp_code.index(el) || temp_code.length) #Deletes the first matching element
      end
    end
    puts
  end

  def win
    puts 'You win!'
    try_again
  end

  def loose
    puts 'You loose ;w;'
    try_again
  end

  def try_again
    puts 'Try again? (Y/N)'
    response = gets.chomp
    if response == 'Y' || response == 'y'
      play
    end
  end
end


mastermind = Mastermind.new(4,5)
mastermind.play
