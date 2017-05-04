class UserOrdersChannel < ApplicationCable::Channel
  def subscribed
     stream_from "orders"
  end

  def unsubscribed
    current_user.disappear
  end
end
