class User < ActiveRecord::Base
  validates :account_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true,
                       confirmation: true,
                      if: :password_required?
  validates :email, uniqueness: true,
                    format: { with: %r{.+@.+\..+} },
                    presence: true
  belongs_to :account
end
