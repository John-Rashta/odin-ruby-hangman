require_relative "file_management"
require_relative "display_helper"
require_relative "player_input"
# Setup and play the game hangman- run setup_game method first
class Game
  include FileManagement
  include DisplayHelper
  include PlayerInput

  def initialize
    @secret_word = []
    @player_progress = []
    @player_guesses = []
    @attempts_left = 8
    @possible_words = load_words
  end

  def setup_game
    option = startup
    if option == "saves"
      all_entries = all_saves
      display_saves(all_entries)
      save_index = ask_save(all_entries.size)
      load_game(save_index == -1 ? all_entries.size - 1 : save_index)
    end
    new_word
    play_game
  end

  private

  def new_game
    new_word
    @player_guesses = []
    @attempts_left = 8
    play_game
  end

  def play_game
    return game_over if @attempts_left.zero?

    display_word(@player_progress, spaces: true)
    display_word(@player_guesses)
    puts "#{@attempts_left} attempts left"
    current_guess = player_guess
    @player_guesses.push(current_guess)
    @attempts_left -= 1
    update_progress(current_guess) if letter_in_word?(current_guess)
    return game_over(won: true) if check_win?

    play_game
  end

  def game_over(won: false)
    if won
      puts "Congratulations, you won with #{@attempts_left} attempts left"
    else
      puts "Better luck next time!"
    end
    display_word(@secret_word, spaces: true)
    display_word(@player_progress, spaces: true)
    display_word(@player_guesses)
    new_game if players_continue_input?
  end

  def start_save
    save_game(%i[secret_word player_progress player_guesses attempts_left],
              [@secret_word, @player_progress, @player_guesses, @attempts_left])
  end

  def load_game(index)
    save = retrieve_save(index)
    @secret_word = save["secret_word"]
    @player_progress = save["player_progress"]
    @player_guesses = save["player_guesses"]
    @attempts_left = save["attempts_left"]
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

  def player_guess
    player_input = ""
    puts "Give a valid guess- must be a character(type save if you want to save)"
    until @player_guesses.none?(player_input) &&
          player_input.size == 1 &&
          player_input.between?("A", "Z")
      player_input = gets.chomp.upcase
      start_save if player_input == "SAVE"
    end
    player_input
  end
end
