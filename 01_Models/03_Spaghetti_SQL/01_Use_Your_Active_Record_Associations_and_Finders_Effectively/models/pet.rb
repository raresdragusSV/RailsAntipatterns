class Pet < ActiveRecord::Base
  has_many :toys

  def find_cute_toys
    self.toys.where(cute: true)
  end
end

# using Proxy Association
class Pet < ActiveRecord::Base
  has_many :toys do
    def cute
      where(cute: true)
    end
  end
end

# using module
class Pet < ActiveRecord::Base
  has_many :toys, extend: ToyAssociationMethods
end

# using simple association or scope
class Pet < ActiveRecord::Base
  has_many :toys
end

# using proxy_owner
class Pet < ActiveRecord::Base
  # has_column :age

  has_many :toys do
    def appropriate
      where(['minimum_age < ?', proxy_owner.age])
    end
  end
end
