require 'json'

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

  def initialize(word_list_file)
    @word_list_file = word_list_file
    @secret_word = []
    @guess_count = 0
    @max_guesses = 10
    @word_guess = []
    @remaining_letters = ('a'..'z').to_a
  end

  attr_reader :word_list_file, :max_guesses
  attr_accessor :secret_word, :guess_count, :word_guess, :remaining_letters

  def start
    self.secret_word = read_word
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
    guess
  end

  def check_guess(guess)

    secret_word.each_with_index do |letter, index|
      word_guess[index] = guess if letter == guess
    end

    secret_word == word_guess
  end

  def read_word
    word_list = File.open(word_list_file, 'r').readlines

    word = word_list.sample.chomp
    word = word_list.sample.chomp while word.length > 12 || word.length < 5

    self.word_guess = Array.new(word.length, '_')

    word.split('')
  end

  def save_game
    puts 'Enter savegame name:'
    filename = gets.chomp
    File.open("#{filename}.json", 'w') do |file|
      file.write(to_json)
    end
    puts 'Game saved'
  end

  def win
    puts 'You win!'
    retry?
  end

  def loose
    puts 'You loose ;w;'
    puts "The word was #{secret_word}"
    retry?
  end

  def retry?
    puts 'Try again? (Y/N)'
    if gets.chomp.downcase == 'y'
      self.guess_count = 0
      self.remaining_letters = ('a'..'z').to_a
      start
    else
      exit
    end
  end

  def to_json(*a)
    {
      'json_class' => self.class.name,
      'data' =>
      {
        :word_list_file => word_list_file,
        :secret_word => secret_word,
        :guess_count => guess_count,
        :max_guesses => max_guesses,
        :remaining_letters => remaining_letters,
        :word_guess => word_guess
      }
    }.to_json(*a)
  end

  def self.json_create(obj)
    hangman = new(obj['data']['word_list_file'])
    hangman.secret_word = obj['data']['secret_word']
    hangman.guess_count = obj['data']['guess_count']
    hangman.remaining_letters = obj['data']['remaining_letters']
    hangman.word_guess = obj['data']['word_guess']
    hangman
  end

  def letter?(char)
    code = char.downcase.ord
    code >= 97 && code <= 122
  end

  def to_s
    'test'
  end
end

def start_game(game_obj)
  puts 'Load game? (Y/N)'
  if gets.chomp.downcase == 'y'
    game = load_game(game_obj)
  else
    game = game_obj.new('google-10000-english-no-swears.txt')
  end
  game.start
end

def load_game(game_obj)
  puts 'Available saves:'
  Dir['./*.json'].entries.each { |name| puts name.chomp('.json') }

  puts 'Enter savegame to load:'
  filename = gets.chomp
  puts "#{filename}.json"

  savedata = File.read("#{filename}.json")
  game_obj.json_create(JSON.parse(savedata))
end

start_game(Hangman)
