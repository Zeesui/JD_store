class Order < ApplicationRecord
	belongs_to :user
	has_many :product_lists


	validates :name, presence: true
  validates :address, presence: true
  validates :cellphone, presence: true

	before_create :generate_token

	#订单编号
	def generate_token
		self.token = SecureRandom.uuid
	end

	def set_payment_with!(method)
		self.update_columns(payment_method: method)
	end

	def pay!
		self.update_columns(is_paid: true)
	end

	include AASM

	aasm do
		state :order_placed, initial: true
		state :paid		   #付款
		state :shipping	 #出货
		state :shipped	 #到货
		state :apply_ship   #确认收货
		state :applying_to_cancell  #申请退货
		state :order_cancelled			#取消订单
		state :good_returned				#允许退货

		event :make_payment, after_commit: :pay! do
			transitions from: :order_placed, to: :paid
		end

		#取消订单
		event :cancell_order do
			transitions from: :order_placed, to: :order_cancelled
		end

		#出货
		event :ship do
			transitions from: :paid, to: :shipping
		end

		# #到货
		# event :deliver do
		# 	transitions from: :shipping, to: :shipped
		# end

		#确认收货
		event :good_shipped do
			transitions from: :shipping, to: :apply_ship
		end

    #申请退货
		event :apply_to_cancelled do
			transitions from: [:paid, :shipping], to: :applying_to_cancell
		end

		#允许退货
		event :return_good do
			transitions from: :applying_to_cancell, to: :good_returned
		end


	end

end
