class Cart < ApplicationRecord
	has_many :cart_items
	has_many :products, :through => :cart_items, source: :product

	def add_product_to_cart(product)
		ci = cart_items.build
		ci.product = product 
		ci.quantity = 1
		ci.save
	end

	def total_price(items)
		sum = 0
		items.each do |cart_item|
			sum += cart_item.quantity * cart_item.product.price
		end
		sum
	end
end
