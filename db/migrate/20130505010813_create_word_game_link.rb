class CreateWordGameLink < ActiveRecord::Migration
  def up
    create_table :word_game_links do |t|
       t.integer :game_id, index: true
       t.integer :word_id, index: true
   #   t.foreign_key :games, :dependent => :delete, :column => 'games_pkey'
   #   t.foreign_key :words, :dependent => :delete, :column => 'words_pkey'
    end
  end

  def down
    drop_table :word_game_links
  end
end
