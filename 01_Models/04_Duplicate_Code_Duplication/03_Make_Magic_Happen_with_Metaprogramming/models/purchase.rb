class Purchase < ActiveRecord::Base
  validates_presence_of  :status
  validates_inclusion_of :status,
                         in: %w(in_progress submitted approved shipped received
                                canceled)

  # Status Finders
  def self.all_in_progress
    where(status: 'in_progress')
  end

  def self.all_submitted
    where(status: 'submitted')
  end

  def self.all_approved
    where(status: 'approved')
  end

  def self.all_shipped
    where(status: 'shipped')
  end

  def self.all_received
    where(status: 'received')
  end

  def self.all_canceled
    where(status: 'canceled')
  end

  # Status Accessors
  def in_progress?
    status == 'in_progress'
  end

  def submitted?
    status == 'submitted'
  end

  def approved?
    status == 'approved'
  end

  def shipped?
    status == 'shipped'
  end

  def received?
    status == 'received'
  end

  def canceled?
    status == 'canceled'
  end
end

# Metaprogramming
class Purchase < ActiveRecord::Base
  STATUSES = %w(in_progress submitted approved shipped received canceled)

  validates_presence_of  :status
  validates_inclusion_of :status, in: STATUSES

  # Status Finders
  class << self
    STATUSES.each do |status_name|
      define_method "all_#{status_name}" do
        where(status: status_name)
      end
    end
  end

  # Status Accessors
  STATUSES.each do |status_name|
    define_method "#{status_name}?" do
      status == status_name
    end
  end
end

# using scopes
class Purchase < ActiveRecord::Base
  validates :status,
            presence: true,
            inclusion: {
              in: %w(in_progress submitted approved shipped received canceled)
            }

  # Status Finders
  scope :all_in_progress, where(status: 'in_progress')
  scope :all_submitted,   where(status: 'submitted')
  scope :all_approved,    where(status: 'approved')
  scope :all_shipped,     where(status: 'shipped')
  scope :all_received,    where(status: 'received')
  scope :all_canceled,    where(status: 'canceled')

  # Status Accessors
  def in_progress?
    status == 'in_progress'
  end

  def submitted?
    status == 'submitted'
  end

  def approved?
    status == 'approved'
  end

  def shipped?
    status == 'shipped'
  end

  def received?
    status == 'received'
  end

  def canceled?
    status == 'canceled'
  end
end

# Metaprograming using scopes
class Purchase < ActiveRecord::Base
  has_statuses :in_progress, :submitted, :approved, :partially_shipped,
               :fully_shipped, :received, :canceled

  scope :all_not_shipped?, where(status: %w(partially_shipped fully_shipped))

  def not_shipped?
    !(partially_shipped? || fully_shipped?)
  end
end
