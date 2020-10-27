class CartItem < ApplicationRecord
	belongs_to :cart 
	belongs_to :product

	def change_quantity(quantity)
		self.quantity += quantity 
		self.save
	end
end
