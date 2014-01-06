class AddQualifiersToRule < ActiveRecord::Migration
  def change
    add_column :rules, :qualifiers, :text
  end
end
