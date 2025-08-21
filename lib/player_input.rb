# Basic Methods for interacting with the player
module PlayerInput
  def ask_save(num)
    player_input = num + 1
    puts "Give a valid save index (type -1 if you want last save)"
    player_input = gets.chomp.to_i until player_input.between?(-1, num - 1)
    player_input
  end

  def startup
    puts "Type saves to get saved games or type start to start a game"
    player_input = ""
    player_input = gets.chomp until %w[start saves].include?(player_input)
    player_input
  end

  def players_continue_input?
    puts "Do you wish to play again?"
    player_answer = gets.chomp.strip.downcase
    return true if %w[y yes yup].include?(player_answer)

    false
  end
end
