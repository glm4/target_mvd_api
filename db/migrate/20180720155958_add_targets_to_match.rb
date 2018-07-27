class AddTargetsToMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :original_target_id, :integer, null: false
    add_column :matches, :matching_target_id, :integer, null: false
  end
end
