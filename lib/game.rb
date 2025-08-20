# Setup and play the game hangman- run setup_game method first
class Game
  def initialize
    @secret_word = []
    @player_progress = []
    @player_guesses = []
    @attempts_left = 8
    File.open("google-10000-english-no-swears.txt") do |f|
      @possible_words = f.filter { |word| word.chomp.size.between?(5, 12) }
    end
  end

  def setup_game
    new_word
  end

  def update_progress(char)
    @secret_word.each_with_index do |ele, index|
      @player_progress[index] = char if ele == char
    end
  end

  def new_word
    @secret_word = random_word.chars
    @player_progress = Array.new(@secret_word.size, "_")
  end

  def random_word
    @possible_words.sample.chomp.upcase
  end

  def check_win?
    @player_progress.eql?(@secret_word)
  end

  def letter_in_word?(char)
    @secret_word.include?(char)
  end

  def valid_guess?(char)
    @player_guesses.none?(char)
  end
end
