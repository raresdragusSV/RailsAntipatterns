class Owner < ActiveRecord::Base
  has_many :toys do
    def cute
      where(cute: true)
    end
  end
end

# using module
class Owner < ActiveRecord::Base
  has_many :toys, extend: ToyAssociationMethods
end
