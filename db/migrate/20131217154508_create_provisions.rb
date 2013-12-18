class CreateProvisions < ActiveRecord::Migration
  def change
    create_table :provisions do |t|
      t.integer :resource_id
      t.integer :event_id

      t.timestamps
    end
  end
end
