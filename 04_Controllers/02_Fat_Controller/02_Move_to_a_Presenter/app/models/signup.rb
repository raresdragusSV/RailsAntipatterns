class Signup < ActivePresenter::Base
  before_save :assign_user_to_account
  presents :user, :account

  private

  def assign_user_to_account
    user.account = account
  end
end
