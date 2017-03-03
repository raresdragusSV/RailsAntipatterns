class Referral < ActiveRecord::Base
  has_and_belongs_to :users
end

# using has_many
class Referral < ActiveRecord::Base
  VALUES = %w(Newsletter School Web Partners/Events Media Other)

  validates :value, inclusion: { in: VALUES }

  belongs_to :user
end
