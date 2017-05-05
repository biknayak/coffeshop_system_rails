class ChecksController < ApplicationController

  def admin
    @user=User.all
  end

  #get all users except current user
  scope :all_except, ->(user) { where.not(id: user) }
  @users = User.all_except(current_user)


end