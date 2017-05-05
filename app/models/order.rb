class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :products, :through => :order_products
  has_one :room
  validates :order_products , presence: true
  validates :room_id , presence: true
  validates :status , presence: true
  scope :created_between, ->(start,ends) { where("created_at >= ? and created_at <= ? ",start,ends ) if start.present? && ends.present? }
  scope :recent_orders, -> (limit) { order("created_at desc").limit(limit) }
end

