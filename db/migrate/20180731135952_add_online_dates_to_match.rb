class AddOnlineDatesToMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :user_a_last_online, :datetime, null: false, default: Time.now
    add_column :matches, :user_b_last_online, :datetime, null: false, default: Time.now
  end
end
