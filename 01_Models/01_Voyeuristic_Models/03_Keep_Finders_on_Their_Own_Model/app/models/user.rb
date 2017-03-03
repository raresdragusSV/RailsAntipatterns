class User < ActiveRecord::Base
  has_many :memberships

  def find_recent_active_memberships
    memberships.where(active: true).limit(5).order('last_active_on DESC')
  end
end

# Refactoring using AssociationProxy Magic

class User < ActiveRecord::Base
  has_many :memberships

  def find_recent_active_memberships
    memberships.find_recently_active
  end
end

# Refactoring using scopes

class User < ActiveRecord::Base
  has_many :memberships

  def find_recent_active_memberships
    memberships.only_active.order_by_activity.limit(5)
  end
end
