class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.decimal :amount, :scale => 2, :precision => 6
      t.string :comment
      t.text :description
      t.integer :registrant_id
      t.integer :charger_id
      t.string :charger_type
      t.string :icon

      t.timestamps
    end
  end
end
