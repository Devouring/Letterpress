class WordGameLink < ActiveRecord::Base
  belongs_to :word
  belongs_to :game
end