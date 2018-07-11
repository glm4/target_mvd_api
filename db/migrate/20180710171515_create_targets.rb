class CreateTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :targets do |t|
      t.string :title
      t.decimal :lat
      t.decimal :lng
      t.float :radius
      t.integer :topic_id

      t.timestamps
    end
  end
end
