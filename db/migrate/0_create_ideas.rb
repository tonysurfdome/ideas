class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :description
    end
  end
end