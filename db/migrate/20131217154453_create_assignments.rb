class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :presenter_id
      t.integer :event_id
      t.boolean :public

      t.timestamps
    end
  end
end
