class Account < ActiveRecord::Base
  def create_account!(account_params, user_params)
    account = Account.create!(account_params)
    first_user = User.new(user_params)
    first_user.admin = true
    first_user.save!
    self.users << first_user
    account.save!
    Mailer.deliver_confirmation(first_user)
    account
  end
end

# refactoring
class Account < ActiveRecord::Base
  accepts_nested_attributes_for :users

  before_create :make_admin_user
  after_create  :send_confirmation_email

  private

  def make_admin_user
    self.users.first.admin = true
  end

  def send_confirmation_email
    Mailer.confirmation(users.first).deliver
  end
end
