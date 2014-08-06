class CreateLocks < ActiveRecord::Migration
  def change
    create_table :locks do |t|
      t.string :name
      t.boolean :locked

      t.timestamps
    end
  end
end
