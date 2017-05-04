class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    # cehck if admin return all else return only user_orders
    @orders = Order.all
    end

  def user_orders
    @orders_user = Order.where(user: current_user)
    render 'user_index'
  end

  def admin_checks
    render 'user_index'
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    unless @order.user == current_user
      flash[:error] = "You are not authorized for this action"
      redirect_to categories_url
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    parameters = order_params
    products = Hash[parameters[:product_ids].zip(parameters[:product_qty])]
    parameters.except!(:product_ids,:product_qty)
    @order = Order.new(parameters)
    flag = @order.save ? true :false
    products.each do |id, qty|
      @order.order_products.create(product_id:id ,quantity:qty)
    end


    respond_to do |format|
      if flag
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    unless @order.user == current_user
      flash[:error] = "You are not authorized for this action"
      redirect_to categories_url
    end
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:note, :status, :total_price, :user_id, :product_qty => [],:product_ids => [])
    end
end
