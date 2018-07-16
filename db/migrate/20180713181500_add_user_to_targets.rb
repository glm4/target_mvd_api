class AddUserToTargets < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :user_id, :integer, null: false
  end
end
