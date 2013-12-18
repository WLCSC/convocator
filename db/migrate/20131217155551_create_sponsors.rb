class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.text :description
      t.text :meta
      t.string :slug

      t.timestamps
    end
  end
end
