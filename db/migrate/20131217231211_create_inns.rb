class CreateInns < ActiveRecord::Migration
  def change
    create_table :inns do |t|
      t.string :name
      t.integer :cost
      t.integer :area_id
      t.integer :hp_regen
      t.integer :mp_regen
      t.string :keeper_image
      t.string :greeting

      t.timestamps
    end
  end
end
