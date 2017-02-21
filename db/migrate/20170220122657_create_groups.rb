class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :status
      t.integer :owner_id
      t.timestamps null: false
      t.text :admin_team
    end
  end
end
