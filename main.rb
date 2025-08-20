if File.exist?("./lib/google-10000-english-no-swears.txt")
  File.open("./lib/google-10000-english-no-swears.txt") do |f|
    new_arr = f.filter { |word| word.chomp.size.between?(5, 12) }
    p new_arr[0]
  end
end
