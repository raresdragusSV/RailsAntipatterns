class Role < ActiveRecod::Base
  has_and_belongs_to_many :users

  validates_presence_of   :name
  validates_uniqueness_of :name

  def name=(value)
    write_attribute('name', value.downcase)
  end

  def self.[](name) # Get a role quickly by using: Role[:admin]
    self.find(:first, conditions: ['name = ?', name.id2name])
  end

  def add_user(user)
    self.users << user
  end

  def delete_user(user)
    self.user.delete(user)
  end
end

# using Simplify with Simple Flags
class Role < ActiveRecod::Base
  TYPES = %w(admin editor writer guest)

  validates :name, inclusion: { in: TYPES }

  class << self
    TYPES.each do |role_type|
      define_method "#{role_type}?" do
        exists?(name: role_type)
      end
    end
  end
end

# refactoring
class Role < ActiveRecod::Base
  TYPES = %w(admin editor writer guest)

  validates :name, inclusion: { in: TYPES }
end
