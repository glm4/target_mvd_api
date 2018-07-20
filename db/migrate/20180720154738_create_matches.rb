class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.string :last_message
      t.integer :unread_messages
      
      t.timestamps
    end
  end
end
