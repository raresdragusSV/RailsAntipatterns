class Membership < ActiveRecord::Base
  belongs_to :user

  def self.find_recently_active
    where(active: true).limit(5).order('last_active_on DESC')
  end
end

# Refactoring using scopes

class Membership < ActiveRecord::Base
  belongs_to :user

  scope :only_active, where(active: true)
  scope :order_by_activity, order('last_active_on DESC')
end
