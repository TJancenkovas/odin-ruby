require 'pry'

module AccuracyFinder

  def get_accuracy(guess, code)
    temp_code = code.clone
    temp_guess = guess.clone
    accuracy = []

    get_exact(temp_guess, temp_code).times { accuracy.append('E') }
    get_partial(temp_guess, temp_code).times { accuracy.append('P') }

    accuracy
  end

  def print_accuracy(guess, code)
    accuracy = get_accuracy(guess, code).each do |result|
      print "#{result} "
    end
    puts
    accuracy
  end

  def get_exact(guess, code)
    exact = 0
    guess.each_with_index do |slot, index|
      next unless slot == code[index]

      exact += 1
      guess[index] = '-'
      code[index] = '-'
    end
    exact
  end

  def get_partial(guess, code)
    partial = 0
    guess.each_with_index do |slot, index|
      next unless slot != '-' && code.include?(slot)

      partial += 1
      remove_index = code.find_index(slot)
      code[remove_index] = 'x'
      guess[index] = 'x'
    end
    partial
  end
end

class Mastermind

  include AccuracyFinder

  attr_reader :numbers, :slots

  def initialize(numbers)
    @slots = 4
    @numbers = numbers
  end

  def start
    puts 'Would you like to guess (G) or create (C) the code? (G/C)'
    loop do
      answer = gets.chomp
      if answer == 'G'
        play_player
      elsif answer == 'C'
        play_cpu
      else
        puts 'Invalid choice, please enter again:'
      end
    end
  end

  def play_player
    code = make_code
    p code
    puts 'Code generated'
    12.times do |n|
      guess = get_guess(n) # Gets guess from user
      submit_guess(guess, code)
    end
    loose
  end

  def play_cpu
    cpu = CpuPlayer.new(slots, numbers)
    # code = make_code_manual
    code = [1, 1, 3, 5]
    p code
    12.times do
      guess = cpu.cpu_guess
      p guess
      cpu.bad_guess(submit_guess(guess, code))
    end
    loose
  end

  # GAME LOGIC HANDLING

  # private

  def submit_guess(guess, code)
    if guess == code
      win
    else
      print_accuracy(guess, code)
    end
  end

  def make_code
    rnd = Random.new

    code = Array.new(slots)
    code.map! { rnd.rand(numbers) }
  end

  def make_code_manual
    puts 'Enter code seperated by spaces:'
    loop do
      code = gets.chomp.split(' ')
      return code.map(&:to_i) if code.length == slots

      puts "Code length must be #{slots}"
    end
  end

  def get_guess(num)
    puts "Enter guess number #{num + 1}:"
    loop do
      guess = gets.chomp.split(' ')
      return guess.map(&:to_i) if guess.length == slots

      puts "Guess length must be #{slots}"
    end
  end

  # GAME END HANDLING

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
    start if response.include?('Y') || response.include?('y')
    exit
  end
end

class CpuPlayer
  # Makes a CPU player object that uses the Knuth codebreaking model

  include AccuracyFinder

  def initialize(slots, numbers)
    @slots = slots
    @numbers = numbers
    @code_set = make_code_set(slots, numbers)
    @s_set = code_set.clone
    @guess = [1, 1, 2, 2]
  end

  attr_accessor :code_set, :s_set
  attr_reader :slots, :numbers, :guess

  def cpu_guess
    if guess == [1, 1, 2, 2]
      first_guess
    else
      next_guess
    end
  end

  def first_guess
    code_set.delete(guess)
  end

  def next_guess(accuracy)
    s_set = remove_same_response(guess, accuracy)
    guess = minimax
    code_set.delete(guess)
  end

  def make_code_set(slots, numbers)
    set = []
    numbers.times { |n| set.append(n) }
    set.repeated_permutation(slots).to_a
  end

  def remove_same_response(guess, accuracy)
    # Needs to remove everything that would not elicit the same response if he guess was the code
    s_set.select do |code|
      get_accuracy(code, guess) == accuracy
    end
  end

  def minimax
    combinations = ['E', 'P'].repeated_permutation(slots).to_a # Create the possible response combinations
    code_set.min_by do |code|
      combinations.max_by do |accuracy|
        remove_same_response(code, accuracy).length #find the maximum amount of remaining guesses for each combo
      end
    end
  end
end


mastermind = Mastermind.new(5)
mastermind.play_cpu
