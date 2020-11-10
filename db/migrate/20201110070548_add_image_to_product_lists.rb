class AddImageToProductLists < ActiveRecord::Migration[5.2]
  def change
    add_column :product_lists, :product_image, :string
  end
end
