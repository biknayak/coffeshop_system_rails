class AdminHomeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "/adminHome"
  end

  def unsubscribed
    stop_all_streams
  end
end
