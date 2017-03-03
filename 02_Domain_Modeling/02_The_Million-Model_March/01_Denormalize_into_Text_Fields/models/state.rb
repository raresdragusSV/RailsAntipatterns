class State < ActiveRecord::Base
  has_many :articles

  validates :name, presence: true

  class << self
    all.each do |state|
      define_method state.to_s do
        first(conditions: { name: state })
      end
    end
  end
end
