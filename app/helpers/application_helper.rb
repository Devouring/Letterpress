module ApplicationHelper
  def generate_hash(word)
    letter_hash = Hash.new{ |hash, key| hash[key] = 0 }
    unless word == nil then
      word = word.gsub(/\W+/, '').chars.sort.join.split("")
      word.each do |letter|
        letter_hash[letter.to_sym] = letter_hash[letter.to_sym] + 1
      end
    end
    return letter_hash
  end

  def read_file
    file = File.new(Rails.root.join('app/assets/files/betterList.txt'), "r")
    while (line = file.gets)
        yield line.gsub(/\W+/, '').downcase
    end
    file.close
  end
end

