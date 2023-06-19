class Hangman
  # Hangman game object
  #   Stores : secret_word, word_guess, remaining_letters, guess_count, max_guesses
  #
  #   Pick random word from list (5-12 char long)
  #   Print word_guess
  #   Print remaining letters
  #   Print guess_count
  #   Get user guess
  #   Run check_user guess (modifies word_guess)
  #   Restart

  def initialize(filename)
    @filename = filename
    @secret_word = []
    @guess_count = 0
    @max_guesses = 10
    @word_guess = []
    @remaining_letters = ('a'..'z').to_a
  end

  attr_reader :filename, :max_guesses
  attr_accessor :secret_word, :guess_count, :word_guess, :remaining_letters

  def start
    puts 'Load game? (Y/N)'
    if gets.chomp.downcase == 'y'
      load_game
    else
      self.secret_word = read_word
    end
    play
  end

  def play
    while guess_count < max_guesses
      put_info
      puts 'Enter guess:'
      guess = read_guess
      win if check_guess(guess)
      self.guess_count += 1
    end

    loose
  end

  def put_info
    word_guess.each { |letter| print "#{letter} " }
    puts
    puts "You have used #{guess_count}/#{max_guesses} guesses."
    puts 'Unused letters:'
    remaining_letters.each { |letter| print "#{letter} " }
    puts
    puts "Type 'save' to save the game"
  end

  def read_guess
    guess = ''
    loop do
      guess = gets.chomp.downcase
      save_game if guess == 'save'
      break if guess.length == 1 && letter?(guess)

      puts 'Please enter a single letter'
    end
    remaining_letters.delete(guess)
  end

  def check_guess(guess)

    secret_word.each_with_index do |letter, index|
      word_guess[index] = guess if letter == guess
    end

    secret_word == word_guess
  end

  def read_word
    word_list = File.open(filename, 'r').readlines

    word = word_list.sample.chomp
    word = word_list.sample.chomp while word.length > 12 || word.length < 5

    self.word_guess = Array.new(word.length, '_')

    word.split('')
  end

  def load_game
    puts 'laod'
  end

  def save_game
    puts 'saved'
  end

  def win
    puts "You win!"
    retry?
  end

  def loose
    puts "You loose ;w;"
    retry?
  end

  def retry?
    puts "Try again? (Y/N)"
    if gets.chomp.downcase == "y"
      self.guess_count = 0
      self.remaining_letters = ('a'..'z').to_a
      play
    else
      exit
    end
  end

  def letter?(char)
    code = char.downcase.ord
    code >= 97 && code <= 122
  end
end


game = Hangman.new('google-10000-english-no-swears.txt')
puts game.start
