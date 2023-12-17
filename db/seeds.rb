# db/seeds.rb

# Clean data
Product.destroy_all
Promotion.destroy_all

# Products
product_attributes = [
  { code: 'GR1', name: 'Green Tea', price: 3.11 },
  { code: 'SR1', name: 'Strawberries', price: 5.00 },
  { code: 'CF1', name: 'Coffee', price: 11.23 },
  { code: 'AP1', name: 'Apple', price: 1.21 }
]

products = product_attributes.map do |product_attr|
  product = Product.find_or_initialize_by(code: product_attr[:code])
  product.update!(name: product_attr[:name], price: product_attr[:price])
  product
end

# Mapping product codes to IDs for easy reference
product_ids = products.map { |p| [p.code, p.id] }.to_h

# Promotions
promotions_attributes = [
  { name: 'Buy One Get One Free - Green Tea', description: 'Buy one green tea, get one free',
    start_date: Date.today, end_date: 1.year.from_now, product_id: product_ids['GR1'] },
  { name: 'Bulk Discount - Strawberries', description: 'Discount on bulk purchase of strawberries',
    start_date: Date.today, end_date: 1.year.from_now, product_id: product_ids['SR1'] },
  { name: 'Coffee Addict Discount', description: 'Discount on bulk purchase of coffee', start_date: Date.today,
    end_date: 1.year.from_now, product_id: product_ids['CF1'] },
  { name: 'Buy Three Get One Free - Apples', description: 'Buy three apples, get one free',
    start_date: Date.today, end_date: 1.year.from_now, product_id: product_ids['AP1'] }
]

promotions = promotions_attributes.map do |promotion|
  Promotion.create!(promotion)
end

# Mapping promotion names to IDs for easy reference
promotion_ids = promotions.map { |p| [p.name, p.id] }.to_h

# PromotionConditions
promotion_conditions = [
  { promotion_id: promotion_ids['Buy One Get One Free - Green Tea'], condition_type: 'min_quantity',
    condition_value: '2' },
  { promotion_id: promotion_ids['Bulk Discount - Strawberries'], condition_type: 'min_quantity', condition_value: '3' },
  { promotion_id: promotion_ids['Coffee Addict Discount'], condition_type: 'min_quantity', condition_value: '3' },
  { promotion_id: promotion_ids['Buy Three Get One Free - Apples'], condition_type: 'min_quantity',
    condition_value: '3' }
]

promotion_conditions.each do |condition|
  PromotionCondition.create!(condition)
end

# PromotionDiscounts
promotion_discounts = [
  { promotion_id: promotion_ids['Buy One Get One Free - Green Tea'], discount_type: 'free_product',
    discount_value: '1' },
  { promotion_id: promotion_ids['Bulk Discount - Strawberries'], discount_type: 'fixed_price', discount_value: '4.50' },
  { promotion_id: promotion_ids['Coffee Addict Discount'], discount_type: 'percentage', discount_value: '33' },
  { promotion_id: promotion_ids['Buy Three Get One Free - Apples'], discount_type: 'free_product', discount_value: '1' }
]

promotion_discounts.each do |discount|
  PromotionDiscount.create!(discount)
end
