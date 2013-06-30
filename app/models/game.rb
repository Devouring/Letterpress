class Game < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :title, :title_ordered, :words
  serialize :words, Array
  validates :title, inclusion: { in: 'a' ..'z' }
  validates :title, length: { minimum: 25, maximum: 25 }
  #
  #find the words for the current game
  def find_all
    self.words = Array.new
    Word.get_ids_for_letters(self.title){|id| self.words << id} 
  end

  def find(first, max)
    list_of_words = Array.new
    Word.get_words_by_ids(self.words[first..max]){|word| list_of_words << word[0]}
    return list_of_words
  end

  def contain(a, b)
    [:e, :t, :a, :o, :i, :n, :s, :r, :h, :l, :d, :c, :u, :m, :f, :p, :g, :w, :y, :b, :v, :k, :x, :j, :q, :z].each do |letter|
      if b[letter] != nil and (a[letter] == nil ? 0 : a[letter]) < b[letter] then return false end
    end
    return true
  end

  def from_subchain(subchain)
    word_from_subchain = Array.new
    @words_list.each do |word|
      if word.text.include_chain(subchain) then word_from_subchain << word end
    end
  end

  def get_words_sorted(subchain)
    subchain_hash = generate_hash(subchain)
    word_list = Array.new
    self.word_game_links.each do |link_word|
      if not link_word.played and link_word.word != nil then
        if contain(link_word.word.letter_hash, subchain_hash) then word_list << link_word.word.text end
      end
    end
    word_list.sort_by{|x| x.length}.reverse
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

