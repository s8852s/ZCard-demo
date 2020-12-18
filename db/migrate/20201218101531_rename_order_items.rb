class RenameOrderItems < ActiveRecord::Migration[6.0]
  def change
    rename_table :oder_items, :order_items
  end
end
