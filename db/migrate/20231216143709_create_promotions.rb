class CreatePromotions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotions do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :product_id

      t.timestamps
    end
  end
end
