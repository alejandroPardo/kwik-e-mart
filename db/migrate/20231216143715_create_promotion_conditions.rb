class CreatePromotionConditions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotion_conditions do |t|
      t.references :promotion, null: false, foreign_key: true
      t.integer :condition_type, default: 0
      t.string :condition_value

      t.timestamps
    end
  end
end
