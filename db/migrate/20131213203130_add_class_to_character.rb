class AddClassToCharacter < ActiveRecord::Migration
  def change

  	add_column :characters, :job, :string

  end
end
