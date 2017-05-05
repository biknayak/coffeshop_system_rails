class ChecksController < ApplicationController

  def index
    @users = User.all

  end

  def user_checks
    # @recent_orders = Order.recent_orders(10)
    @checks = Order.where('user_id'=>params[:id]).created_between(params[:start],params[:end])
    render json: @checks
  end

  def show
  end

  def destroy
    respond_to do |format|
      format.html { redirect_to checks_url, notice: 'Check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end

