class WordGameLink < ActiveRecord::Base
  attr_accessible :played
  belongs_to :word
  belongs_to :game
  def play
    self.played = self.played ? false : true
  end
end