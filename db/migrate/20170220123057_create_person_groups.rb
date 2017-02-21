class CreatePersonGroups < ActiveRecord::Migration
  def change
    create_table :person_groups do |t|
    	t.references :group, index: true
      t.references :person, index: true
      t.timestamps null: false
    end
  end
end
