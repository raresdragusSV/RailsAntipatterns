class SignupControllerTest < ApplicationController::TestCase
  context 'on GET to #new' do
    setup { get :new }
    should assign_to(:signup)
    should render_template(:new)

    should 'render form for signup' do
      assert_select 'form[action$=?]', signups_path do
        assert_select 'input[name=?]', 'signup[account_subdomain]'
        assert_select 'input[name=?]', 'signup[user_email]'
        assert_select 'input[name=?]', 'signup[user_password]'
      end
    end
  end

  context 'on POST to #create with good values' do
    setup do
      post :create,
           signup: {
             account_subdomain: 'foo',
             user_email: 'foo@bar.com',
             user_password: 'pass'
           }
    end

    should set_the_flash.to(/thank you/i)
    should_change 'User.count', by: 1
    should_change 'Account.count', by: 1
  end

  context 'on POST to #create with bad account values' do
    setup do
      post :create,
           signup: {
             user_email: 'foo@bar.com',
             user_password: 'pass'
           }
    end

    should_not_change 'User.count'
    should_not_change 'Account.count'
    should assign_to(:signup)
    should render_template(:new)
  end

  context 'on POST to #create with bad user values' do
    setup do
      post :create,
           signup: { account_subdomain: 'foo' }
    end

    should_not_change 'User.count'
    should_not_change 'Account.count'
    should assign_to(:signup)
    should render_template(:new)
  end
end
