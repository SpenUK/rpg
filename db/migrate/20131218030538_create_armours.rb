class CreateArmours < ActiveRecord::Migration
  def change
    create_table :armours do |t|
      t.string :name
      t.string :description
      t.integer :base_def
      t.integer :def_range
      t.integer :base_price

      t.timestamps
    end
  end
end
