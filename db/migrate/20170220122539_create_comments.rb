class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :description
      t.references :parent_comment, index: true
      t.references :post, index: true
      t.timestamps null: false
    end
  end
end
