class RemoveUnreadMessagesFromMatch < ActiveRecord::Migration[5.1]
  def change
    remove_column :matches, :unread_messages
  end
end
