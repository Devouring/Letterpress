class WordFinder
  @words_list = []
  def initialize(letters)
    file_reader("wordsEn.txt")
    find(letters)
  end

  def file_reader(filePath)
    @words_list = Hash.new
    file = File.new(filePath, "r")
    while (line = file.gets)
      @words_list[line.gsub(/\W+/, '').to_sym] = create_hash(line)
    end
    file.close
  end

  #create a letter hash from a word
  def create_hash(word)
    word_hash = Hash.new{ |hash, key| hash[key] = 0 }
    line_array = word.gsub(/\W+/, '').chars.sort.join.split("")
    line_array.each do |line_letter|
      word_hash[line_letter.to_sym] = word_hash[line_letter.to_sym] + 1
    end
    return word_hash
  end

  def find(letters)
    good_words = Array.new
    letters_hash = create_hash(letters)
    @words_list.each do |key, word|
      if contain(letters_hash, word) then good_words << key.to_s end
    end
    @words_list = good_words
  end

  def contain(a, b)
    isContained = true
    ("a".."z").each do |letter|
      if a[letter.to_sym] < b[letter.to_sym] then
      isContained = false
      break
      end
    end
    return isContained
  end

  def print(subchain)
    @words_list.each do |word|
      if word.include_chain(subchain) then puts word end
    end
  end
  def get_words_list_from_chain(chain)
     good_words = Array.new
     @words_list.each do |word|
      if word.include_chain(subchain) then good_words << word end
    end
    return good_words
  end
end

class String
  def include_chain(chain)
    if self.empty? then return false end
    to_be_returned = true
    chain_array = chain.gsub(/\W+/, '').chars.sort.join.split("")
    chain_array.each do |letter|
      if not self.include?(letter) then
      to_be_returned = false
      break
      end
    end
    return to_be_returned
  end
end
