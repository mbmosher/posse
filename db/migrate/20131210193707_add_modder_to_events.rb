class AddModderToEvents < ActiveRecord::Migration
  def change
    add_column :events, :modder, :integer
  end
end
