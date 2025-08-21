# Basic Methods do display strings
module DisplayHelper
  def display_word(word, spaces: false)
    word.each do |chr|
      print chr
      print " " if spaces
    end
    puts ""
  end

  def display_saves(saves)
    saves.each { |save| puts save }
  end
end
