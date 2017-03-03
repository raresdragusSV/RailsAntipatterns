# Big Brother Is Watching

class Tweet < ActiveRecord::Base
  before_create :send_tweet

  def send_tweet
    twitter_client.update(body)
  rescue *TWITTER_EXCEPTIONS => e
    HoptoadNotifier.notify e
    errors.add_to_base('Could not contact Twitter.')
  end
end

# Never Rescue nil
# in controller

order_number = order.place! rescue nil
if order_number.nil?
  flash[:error] = 'Unable to reach Fulfillment House.'\
                  ' Please try again.'
end

class Order < ActiveRecord::Base
  def place!
    fh_order = send_to_fulfillment_house!
    self.fulfillment_house_order_number = fh_order.number
    save!
    fh_order.number
  end
end

# Make It Pretty

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors
end
