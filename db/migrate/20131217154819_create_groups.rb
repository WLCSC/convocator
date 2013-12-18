class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :parent_id
      t.boolean :approvable
      t.boolean :joinable

      t.timestamps
    end
  end
end
