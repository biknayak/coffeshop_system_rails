class UserOrdersChannel < ApplicationCable::Channel
  def subscribed
     stream_from "orders/#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
