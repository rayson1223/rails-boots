class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
  	rakeadd_index :roles, :name,                unique: true
  end


end
