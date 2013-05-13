class Game < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :title
  attr_accessible :title_ordered
  attr_accessible :words
  attr_accessible :word_game_links

  has_many :word_game_links
  has_many :words, :through => :word_game_links
  def find
    good_words = Array.new
    title_hash = generate_hash(self.title)
    Word.all.each do |word|
      if contain(title_hash, word.letter_hash) then good_words << word end
    end
    self.words = good_words
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

  def get_words_played_sorted
    word_list = Array.new
    self.word_game_links.each do |link_word|
      if link_word.played then word_list << link_word.word.text end
    end
    word_list.sort_by{|x| x.length}.reverse
  end

  def get_words_sorted(subchain)
    subchain_hash = generate_hash(subchain)
    word_list = Array.new
    self.word_game_links.each do |link_word|
      if not link_word.played and link.word != nil then
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

