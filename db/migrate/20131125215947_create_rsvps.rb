class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :attending

      t.timestamps
    end
  end
end
