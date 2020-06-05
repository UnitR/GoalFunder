class PaymentChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'payments'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
