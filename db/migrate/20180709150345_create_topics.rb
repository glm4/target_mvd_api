class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.string :icon

      t.timestamps
    end
  end
end
