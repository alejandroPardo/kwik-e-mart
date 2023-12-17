class CreatePromotionDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :promotion_discounts do |t|
      t.references :promotion, null: false, foreign_key: true
      t.integer :discount_type, default: 0
      t.decimal :discount_value

      t.timestamps
    end
  end
end
