class AddPlayedColumn < ActiveRecord::Migration
  def up
    add_column :word_game_links, :played, :boolean
  end

  def down
    remove_column :word_game_links, :played, :boolean
  end
end
