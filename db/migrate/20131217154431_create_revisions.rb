class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.text :diff
      t.integer :presenter_id
      t.integer :event_id
      t.boolean :approved

      t.timestamps
    end
  end
end
