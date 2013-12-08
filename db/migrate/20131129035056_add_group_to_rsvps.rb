class AddGroupToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :group_id, :integer
  end
end
