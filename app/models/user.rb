class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_one :room


  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :remember_me, :avatar, :avatar_cache, :remove_avatar

  validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  def store_dir
    'public/assets/images'
  end

  # u = User.new
  # File.open('public/assets/images/lyn.jpg') do |f|
  #   u.avatar = f
  # end
  #
  # u.save!
  # u.avatar.url # => '/url/to/file.png'
  # u.avatar.current_path # => 'path/to/file.png'
  # u.avatar_identifier # => 'file.png'
end



