class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :description
      t.integer :likes, :default => 0
      t.timestamps
    end
  end
end