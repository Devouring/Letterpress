class RemoveUselessTables < ActiveRecord::Migration
  def up
    drop_table :word_game_links
    drop_table :words
    add_column :games, :words, :text
  end

  def down
    create_table :word_game_links do |t|
      t.integer :game_id, index: true
      t.integer :word_id, index: true
    end
  end
end
