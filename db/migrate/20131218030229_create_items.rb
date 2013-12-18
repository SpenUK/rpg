class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :subclass_id
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end
