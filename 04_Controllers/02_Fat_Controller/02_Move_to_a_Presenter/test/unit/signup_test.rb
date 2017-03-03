class SignupTest < ActiveSupport::TestCase
  should validate_presence_of :account_subdomain
  should validate_presence_of :user_email
  should validate_presence_of :user_password

  should 'be a presenter for account and user' do
    assert_contains Signup.new.presented.keys, :account
    assert_contains Signup.new.presented.keys, :user
  end

  should 'assign the user to the account on save' do
    signup = Signup.new(
      account_subdomain: 'subdomain',
      user_email: 'foo@bar.com',
      user_passowrd: 'password'
    )
    assert signup.save
    assert user = signup.user
    assert account = signup.account
    assert_equal account.id, user.account_id
  end
end
