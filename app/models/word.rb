class Word < ActiveRecord::Base
  serialize :letter_hash, Hash
  validates :text, presence: true
  attr_accessible :text
  attr_accessible :letter_hash
  attr_accessible :words
  has_many :word_game_links
  has_many :games, :through => :word_game_links
end
