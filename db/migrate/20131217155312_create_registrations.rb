class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :event_id
      t.integer :registrant_id
      t.boolean :waiting

      t.timestamps
    end
  end
end
