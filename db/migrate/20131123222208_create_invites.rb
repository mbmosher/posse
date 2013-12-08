class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
