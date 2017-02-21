class CreateInviteHistories < ActiveRecord::Migration
  def change
    create_table :invite_histories do |t|
    	t.string :invited_by
      t.string :invited_to
      t.references :group, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
