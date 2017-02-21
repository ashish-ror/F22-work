class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :description
      t.references :group, index: true
      t.references :person, index: true
      t.timestamps null: false
    end
  end
end
