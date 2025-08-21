require "msgpack"
require "date"
# Handle saving and loading files
module FileManagement
  def save_game(keys, values)
    msg = MessagePack.pack(keys.zip(values).to_h)
    File.binwrite("saves/#{DateTime.now}.msgpack", msg)
  end

  def load_words
    File.open(File.join(File.dirname(__FILE__), "google-10000-english-no-swears.txt")) do |f|
      f.filter { |word| word.chomp.size.between?(5, 12) }
    end
  end

  def all_saves
    Dir.entries("saves")
  end

  def retrieve_save(index)
    fls = all_saves
    msg = File.binread("saves/#{fls[index]}")
    MessagePack.unpack(msg)
  end
end
