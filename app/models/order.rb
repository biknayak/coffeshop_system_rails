class Order < ApplicationRecord
  belongs_to :user
  has_many :orderproducts
  has_many :products, :through => :order_products
end
