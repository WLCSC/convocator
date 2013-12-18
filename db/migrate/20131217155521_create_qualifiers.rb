class CreateQualifiers < ActiveRecord::Migration
  def change
    create_table :qualifiers do |t|
      t.string :name
      t.text :description
      t.integer :group_id
      t.text :meta

      t.timestamps
    end
  end
end
