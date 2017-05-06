class UserOrdersChannel < ApplicationCable::Channel
  def subscribed
     stream_from "orders/#{current_user.id}"
     stream_from "orders/new"
  end

  def unsubscribed
    stop_all_streams
  end
end
