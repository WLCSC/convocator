class CreateNavigators < ActiveRecord::Migration
  def change
    create_table :navigators do |t|
      t.string :name
      t.integer :parent_id
      t.integer :page_id
      t.text :meta

      t.timestamps
    end
  end
end
