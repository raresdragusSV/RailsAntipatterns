class Article < ActiveRecord::Base
  belongs_to :state
  belongs_to :category

  validates :state_id,    presence: true
  validates :category_id, presence: true
end

# denormalize
class Article < ActiveRecord::Base
  STATES =     %w(draft review published archived)
  CATEGORIES = %w(tips faqs misc)

  validates :state,    inclusion: { in: STATES }
  validates :category, inclusion: { in: CATEGORIES }

  STATES.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end

  CATEGORIES.each do |category|
    define_method "#{category}?" do
      self.category == category
    end
  end

  class << self
    STATES.each do |state|
      define_method state.to_s do
        state
      end
    end

    CATEGORIES.each do |category|
      define_method category.to_s do
        category
      end
    end
  end
end
