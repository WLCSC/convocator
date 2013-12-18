class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.integer :user_id
      t.string :slug
      t.text :meta

      t.timestamps
    end
  end
end
