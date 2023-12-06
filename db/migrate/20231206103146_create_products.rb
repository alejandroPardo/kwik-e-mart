class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :code
      t.text :name
      t.decimal :price

      t.timestamps
    end
  end
end
