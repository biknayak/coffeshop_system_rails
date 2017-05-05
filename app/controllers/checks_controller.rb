class ChecksController < ApplicationController

  def admin
    @user=User.all
  end

end