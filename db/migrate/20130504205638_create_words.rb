class CreateWords < ActiveRecord::Migration
  def up
    create_table :words do |t|
      t.string :text
      t.text :letter_hash
    end
  end

  def down
    drop_table :words
  end
end
