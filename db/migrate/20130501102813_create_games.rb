class CreateGames < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.string :title
      t.string :title_ordered
      t.datetime :date_added
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
    end
  end

  def down
    drop_table :games
  end
end
