class CreateItemInstances < ActiveRecord::Migration
  def change
    create_table :item_instances do |t|
      t.string :category
      t.integer :item_id
      t.integer :owner_id
      t.integer :owner_type
      t.integer :condition

      t.timestamps
    end
  end
end
