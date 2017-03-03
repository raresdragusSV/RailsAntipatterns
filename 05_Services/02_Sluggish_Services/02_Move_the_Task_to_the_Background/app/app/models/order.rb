class Order < ActiveRecord::Base
  def send_order
    Delayed::Job.enqueue SendOrderJob.new(self)
  end
end
