class Product < ActiveRecord::Base
  has_many :order_products
  has_many :orders, :through => :order_products

  mount_uploader :Image, ImageUploader


  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :remember_me, :avatar, :avatar_cache, :remove_avatar

  validates_presence_of   :Image
  validates_integrity_of  :Image
  validates_processing_of :Image

  def store_dir
    'public/assets/images'
  end

end
