class GamePlayedArray < ActiveRecord::Migration
  def up
        add_column :games, :played, :text
  end

  def down
  end
end
