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
end
