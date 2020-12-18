class CreateOderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :oder_items do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity
      t.belongs_to :order, null: false, foreign_key: true
      t.string :sell_price

      t.timestamps
    end
  end
end
