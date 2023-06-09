class AddOrderToCart < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :order, null: true, foreign_key: true
    add_column :carts, :isorder, :boolean, default: false
  end
end


