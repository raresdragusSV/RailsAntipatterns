class SendOrderJob < struct.new(:message, :action_lins)
  def perform(order)
    OrderSender.send_order(order)
  end
end
