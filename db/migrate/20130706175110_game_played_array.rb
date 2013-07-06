class GamePlayedArray < ActiveRecord::Migration
  def up
    add_column :games, :played, :text
  end

  def down
    drop_column :games, :played
  end
end
