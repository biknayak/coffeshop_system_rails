class AdminHomeController < ApplicationController
  def index
    @orders = Order.where(" status = 'processing'")
    @rooms = []
    @orders.each { |x|

        @rooms.push(Room.find(x.room_id))
     }
    puts @rooms
    puts @orders
  end

  def change
    if Order.update(params[:orderID],:status => 'Out For Delivery')
      ActionCable.server.broadcast("orders/#{params[:userID]}",{to:"all",state: 'Out For Delivery',orderID:params[:orderID]})
    end
    redirect_to '/adminHome'
  end
end
