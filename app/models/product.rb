class Product < ApplicationRecord
	mount_uploader :image, ImageUploader

	has_many :cart_items
	has_many :product_relationships
  has_many :members, :through => :product_relationships, :source => :user

	def public!
		self.is_hidden = false
		self.save
	end

	def hide!
		self.is_hidden = true
		self.save
	end
end
