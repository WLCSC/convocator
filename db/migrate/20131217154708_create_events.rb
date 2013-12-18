class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start
      t.datetime :end
      t.integer :limit
      t.decimal :cost, :precision => 6, :scale => 2
      t.boolean :waitable
      t.string :icon
      t.string :slug
      t.text :meta

      t.timestamps
    end
  end
end
