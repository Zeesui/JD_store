class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def admin?
         	is_admin
         end

         has_many :orders

         has_many :product_relationships
         has_many :favorited_products, :through => :product_relationships, :source => :product
          # user.favorited_products 用户收藏的商品

         #判断商品是否已收藏
          def is_member_of(product)
            favorited_products.include?(product)
          end

          #加入收藏
          def collected_product!(product)
            favorited_products << product
          end

          #取消收藏
          def uncollected_product!(product)
            favorited_products.delete(product)
          end
end
