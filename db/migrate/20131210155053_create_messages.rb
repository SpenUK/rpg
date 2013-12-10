class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :sender_id
      t.string :title
      t.text :body
      t.string :message_type

      t.timestamps
    end
  end
end
