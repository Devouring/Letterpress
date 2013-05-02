class DateColumnModifcations < ActiveRecord::Migration
  def up
    remove_column :games, :date_added, :datetime
  end

  def down
    add_column :games, :date_added, :datetime
  end
end
