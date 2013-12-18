class CreateRulers < ActiveRecord::Migration
  def change
    create_table :rulers do |t|
      t.integer :event_id
      t.integer :rule_id

      t.timestamps
    end
  end
end
