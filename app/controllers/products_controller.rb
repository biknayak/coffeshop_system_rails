class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    @products_user = Product.joins(:orders).where('orders.user_id' => current_user.id).distinct
    # format.html { render :edit }
    respond_to do |format|  ## Add this
      format.json { render json: @products , status: :ok }
      format.html { render :index }
      ## Other format
    end
  end


  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    print(params[:product_name])
    product_name = params[:product_name]
    if product_name != '+_all'
      @products = Product.where("status = 'available' and name LIKE ?", "%#{product_name}%")
    else
      @products = Product.where("status = 'available'")
    end
    # format.html { render :edit }
    respond_to do |format|  ## Add this
      format.json { render json: @products , status: :ok }
      format.html {  render json: @products , status: :ok  }
      ## Other format
    end                    ## Add this

  end

  def changeProductState
    if Product.update(params[:productID],:status => params[:state])
      ActionCable.server.broadcast("orders/new",{to:"new",state:params[:state],productID:params[:productID]})
    end
    redirect_to '/products'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :Image, :price, :status)
    end
end
