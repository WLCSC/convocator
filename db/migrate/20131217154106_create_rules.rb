class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :group_id
      t.text :meta

      t.timestamps
    end
  end
end
