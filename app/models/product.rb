class Product < ApplicationRecord
  has_many :orderproducts
  has_many :products, :through => :order_products
end
