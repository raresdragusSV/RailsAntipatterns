class Toy < ActiveRecord::Base
  def self.cute
    where(cute: true)
  end
end

# using scope
class Toy < ActiveRecord::Base
  scope :cute, where(cute: true)
end

# using proxy_owner
class Toy < ActiveRecord::Base
  # has column :minimum_age
end
