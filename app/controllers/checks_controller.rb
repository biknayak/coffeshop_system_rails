class ChecksController < ApplicationController
  before_action :set_check, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @total= Order.group('user_id').sum('total_price')

  end

  def user_checks
    if params[:start] !=0 and params[:ends]
      @checks = Order.where('user_id'=>params[:id]).created_between(params[:start],params[:ends])
    else
      @checks = Order.where('user_id'=>params[:id])
    end
      render json: @checks
  end

  def check_product
    @products=Order.find(params[:id]).products
    @products=OrderProduct.where('order_id'=>params[:id])
    render json: @products, include: ['product']
  end

  def destroy
    respond_to do |format|
      format.html { redirect_to checks_url, notice: 'Check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
