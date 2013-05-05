class AddTimestampColumn < ActiveRecord::Migration
  def up
    add_column(:games, :created_at, :datetime)
    add_column(:games, :updated_at, :datetime)
    add_column(:words, :created_at, :datetime)
    add_column(:words, :updated_at, :datetime)
  end

  def down
    remove_column(:games, :created_at, :datetime)
    remove_column(:games, :updated_at, :datetime)
    remove_column(:words, :created_at, :datetime)
    remove_column(:words, :updated_at, :datetime)
  end
end
