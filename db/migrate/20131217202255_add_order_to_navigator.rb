class AddOrderToNavigator < ActiveRecord::Migration
  def change
    add_column :navigators, :order, :integer
  end
end
