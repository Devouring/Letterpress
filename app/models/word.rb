class Word
  def self.all
    return word_hash
  end

  def self.get_words_by_ids(ids)
    array_of_words = Word.all
    ids.each do |id|
      yield array_of_words[id]
    end
  end

  def self.get_ids_for_letters(letters)
    title_hash = generate_hash(letters)
    array_of_words = Word.all
    array_of_words.each_with_index do |word, index|
      if contain(title_hash, word[1]) then
        yield index
      end
    end
  end

  def self.generate_hash(word)
    letter_hash = Hash.new { |hash, key| hash[key] = 0 }
    unless word == nil then
      word = word.gsub(/\W+/, '').chars.sort.join.split("")
      word.each do |letter|
        letter_hash[letter] = letter_hash[letter] + 1
      end
    end
    return letter_hash
  end

  def self.read_file
    File.open(Rails.root.join('app/assets/files/wordsEn.txt'), "r").each_line do |line|
      line.gsub!(/[^a-zA-Z]/, '')
      unless line.length < 3 then
        yield line.downcase
      end
    end
  end

  def self.hash_and_save_to_json
    array_of_word = Array.new
    read_file do |word|
      array_of_word << [word, generate_hash(word)]
    end
    array_of_word.sort_by! { |a| a[0].size }
    array_of_word.reverse!
    File.open("app/assets/files/word_hash.json", "w") do |f|
      f.write(JSON.pretty_generate(array_of_word))
    end
  end

  def self.word_hash
    return JSON.parse(IO.read(File.open("app/assets/files/word_hash.json", "r")))
  end

  def self.contain(word, sub_chain)
    [:e, :t, :a, :o, :i, :n, :s, :r, :h, :l, :d, :c, :u, :m, :f, :p, :g, :w, :y, :b, :v, :k, :x, :j, :q, :z].each do |letter|
      if sub_chain[letter.to_s] != nil and (word[letter.to_s] == nil ? 0 : word[letter.to_s]) < sub_chain[letter.to_s] then
        return false
      end
    end
    return true
  end
end

