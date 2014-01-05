class AddInventorySlotsToCharacter < ActiveRecord::Migration
  def change

  	add_column :characters, :hat_id , :integer
  	add_column :characters, :top_id , :integer
  	add_column :characters, :bottoms_id , :integer
  	add_column :characters, :left_hand_id , :integer
  	add_column :characters, :right_hand_id , :integer
  	add_column :characters, :shoes_id , :integer
  	add_column :characters, :held1_id , :integer
  	add_column :characters, :held2_id , :integer
		add_column :characters, :held3_id , :integer
		add_column :characters, :held4_id , :integer
		add_column :characters, :held5_id , :integer
		add_column :characters, :held6_id , :integer
  	add_column :characters, :held7_id , :integer
  	add_column :characters, :held8_id , :integer

  end
end
