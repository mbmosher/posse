class AddDatetimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :datetime, :datetime
  end
end
