class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.integer :status

      t.timestamps
    end
  end
end
