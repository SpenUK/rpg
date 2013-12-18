class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.integer :area_id
      t.string :owner_image

      t.timestamps
    end

    create_table :consumables_vendors do |t|
    	t.integer :consumable_id
      t.integer :vendor_id

    end

  end
end
