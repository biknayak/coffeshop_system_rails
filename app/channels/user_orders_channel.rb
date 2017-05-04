class UserOrdersChannel < ApplicationCable::Channel
  def subscribed
     stream_from "orders:#{current_user.id}"
  end

  def unsubscribed
    current_user.disappear
  end
end
