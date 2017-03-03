class User < ActiveRecord::Base
  has_many :referral_types
end

# using serialization
class User < ActiveRecord::Base
  HEARD_THROUGH_VALUES = %w(Newsletter School Web Media Partners/Events Other)

  serialize :heard_through, Hash
end
