class AddLockToEvent < ActiveRecord::Migration
  def change
    add_column :events, :lock_id, :integer
  end
end
