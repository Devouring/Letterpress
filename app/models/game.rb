class Game < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :title, :title_ordered, :words, :played
  serialize :words, Array
  serialize :played, Array
  validates :title, inclusion: {in: 'a' ..'z'}
  validates :title, length: {minimum: 25, maximum: 25}
  #
  #find the words for the current game
  def find_all
    self.words = Array.new
    Word.get_ids_for_letters(self.title) { |id| self.words << id }
  end

  ##
  #return a list a word
  def find(offset, max, sub_chain_to_keep, sub_chain_to_remove)
    list_of_words = Array.new
    counter = 0
    if (sub_chain_to_keep == nil or sub_chain_to_keep.length == 0) and (sub_chain_to_remove == nil or sub_chain_to_remove.length == 0)
      Word.get_words_by_ids(self.words[offset..max]) { |word| list_of_words << word[0] }
    else
      Word.get_words_by_ids(self.words) do |word|
        if is_a_sub_chain(word[1], Word.generate_hash(sub_chain_to_keep), Word.generate_hash(sub_chain_to_remove))
          if counter >= offset and counter <= offset + max
          list_of_words << word[0]
          end
          counter = counter + 1
          if counter > offset + max
          break
          end
        end
      end
    end
    list_of_words
  end

  def get_played_words
    list_of_words = Array.new
    Word.get_words_by_ids(self.played) { |word| list_of_words << word[0] }
    list_of_words
  end

  ##
  # move a word from to the played list
  def play(word_to_find)
    id = get_id(words, word_to_find)
    played << words[id]
    words.delete_at id
  end

  def unplay(word_to_find)
    id = get_id(played, word_to_find)
    words << played[id]
    played.delete_at id
    words.sort!
  end

  def get_id(array, word_to_find)
    counter = 0
    Word.get_words_by_ids(array) do |word|
      if word[0] == word_to_find then
      return counter
      end
      counter = counter + 1
    end
    nil
  end

  def is_a_sub_chain(word, sub_chain_to_keep, sub_chain_to_remove)
    [:e, :t, :a, :o, :i, :n, :s, :r, :h, :l, :d, :c, :u, :m, :f, :p, :g, :w, :y, :b, :v, :k, :x, :j, :q, :z].each do |letter|
      if sub_chain_to_keep[letter.to_s] != nil and (word[letter.to_s] == nil ? 0 : word[letter.to_s]) < sub_chain_to_keep[letter.to_s]
      return false
      end
      if  (sub_chain_to_remove[letter.to_s] == nil ? 0 : sub_chain_to_remove[letter.to_s]) > 0 and (word[letter.to_s] == nil ? 0 : word[letter.to_s]) > 0
      return false
      end
    end
    true
  end
end

