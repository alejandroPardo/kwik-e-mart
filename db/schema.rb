# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_16_143722) do
  create_table "invoice_items", force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.integer "product_id"
    t.integer "quantity"
    t.decimal "unit_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
    t.index ["product_id"], name: "index_invoice_items_on_product_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.text "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promotion_conditions", force: :cascade do |t|
    t.integer "promotion_id", null: false
    t.integer "condition_type", default: 0
    t.string "condition_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promotion_id"], name: "index_promotion_conditions_on_promotion_id"
  end

  create_table "promotion_discounts", force: :cascade do |t|
    t.integer "promotion_id", null: false
    t.integer "discount_type", default: 0
    t.decimal "discount_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promotion_id"], name: "index_promotion_discounts_on_promotion_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
