class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    # still need login authorization check
    if current_user.is_admin == 1
      @orders = Order.all
    else
      @orders = current_user.orders
    end
  end

  def user_orders
    @orders_user = Order.where(user: current_user)
    render 'user_index'
  end

  # get order products
  def orderProducts
    @order = Order.find(params[:id])
    @products = @order.order_products
    puts @products[0].product.name
    @productsInfo = []
    @products.each { |x|
        @productsInfo.push(x.product)
     }
     puts @products.inspect
    render :json => {:success => true,:total_price=>@order.total_price,:products => @products.as_json(),:productsinfo => @productsInfo}
  end

  # admin Home orders
  def adminHome order
    puts order.id
    puts "admin Home"
    @room = Room.find(order.room_id)
    puts order.room_id
    @userName = order.user
    @products = order.order_products
    puts @products[0].product.name
    @productsInfo = []
    @products.each { |x|
        @productsInfo.push(x.product)
     }
    ActionCable.server.broadcast("/adminHome",{state:"add",order:order,user:@userName,products:@products.as_json(),productsinfo: @productsInfo,room:@room.number})
  end

  # GET /orders/1
  #ET /orders/1.json
  def show
    unless @order.user == current_user
      flash[:error] = "You are not authorized for this action"
      redirect_to categories_url
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    if current_user.is_admin != 1
      @latest_order = current_user.orders.order('created_at').last
    end
    @products = Product.where("status = 'available'")

  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    #decode order params
    order = JSON.parse params[:order]
    user_id = params[:user_id]
    order_note = params[:order_note]
    order_room = params[:room_id].to_i
    @order = Order.new()
    total_price = 0
    order_products = Array.new
    order.each do |product|
      single_order_product = OrderProduct.new({quantity: product[2].to_i ,product_id: product[0].to_i })
      total_price += single_order_product.product.price.to_i * single_order_product.quantity.to_i
      order_products.push(single_order_product)
    end

    # set order products
    if order_products.count != 0
      @order.order_products = order_products
    end

    # assign user
    if(current_user.is_admin == 1 )
      @order.user = User.find(user_id)
    else
      @order.user = current_user
    end
    print(order_room)
    @order.room_id = order_room
    @order.note = order_note
    @order.status = "processing"
    @order.total_price = total_price
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
        adminHome @order
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
    if @order.user != current_user
      flash[:error] = "You are not authorized for this action"
      redirect_to orders_url
    else
      @order.destroy
      flash[:notice] ='Order was successfully Deleted.'
      ActionCable.server.broadcast("/adminHome",{state:"remove",orderID:@order.id})
      redirect_to orders_url
    end
    # respond_to do |format|
    #   format.html { render orders_url, notice:  }
    #   format.json { head :no_content }
    # end
  end

  def ordersWithinDate
    @orders = Order.where('user_id'=> current_user.id).created_between(params[:start],params[:end])
    puts @orders
    render json: @orders
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:note, :status, :total_price, :user_id, :order_products, :room_id)
    end
end
