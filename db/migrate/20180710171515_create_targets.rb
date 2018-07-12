class CreateTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.decimal :lat, null: false
      t.decimal :lng, null: false
      t.float :radius, null: false
      t.integer :topic_id, null: false

      t.timestamps
    end
  end
end
