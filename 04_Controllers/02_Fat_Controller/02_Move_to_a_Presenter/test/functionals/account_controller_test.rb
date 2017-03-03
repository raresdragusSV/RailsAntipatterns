class AccountControllerTest < ApplicationController::TestCase
  context 'on GET to #new' do
    setup { get :new }
    should assign_to(:account)
    should assign_to(:user)
    should render_template(:new)

    should 'render form for account and user' do
      assert_select 'form[action$=?', accounts_path do
        assert_select 'input[name=?', 'account[subdomain]'
        assert_select 'input[name=?', 'user[email]'
        assert_select 'input[name=?', 'user[password]'
      end
    end
  end

  context 'on POST to #create with good values' do
    setup do
      post :create,
           account: { subdomain: 'foo' },
           user: { email: 'foo@bar.com', password: 'pass' }
    end

    should set_the_flash.to(/created/i)
    should_change 'User.count', by: 1
    should_change 'Account.count', by: 1
    should 'assign the user to the account' do
      assert_equal assigns(:account).id, assigns(:user.account_id)
    end
  end

  context 'on POST to #create with bad account values' do
    setup do
      post :create,
           account: {},
           user: { email: 'foo@bar.com', password: 'pass' }
    end

    should assign_to(:account)
    should assign_to(:user)
    should render_template(:new)
  end

  context 'on POST to #create with bad user values' do
    setup do
      post :create,
           account: { subdomain: 'foo' },
           user: {}
    end

    should assign_to(:account)
    should assign_to(:user)
    should render_template(:new)
  end
end

# refactoring catching the bug

class AccountControllerTest < ApplicationController::TestCase
  context 'on GET to #new' do
    setup { get :new }
    should assign_to(:account)
    should assign_to(:user)
    should render_template(:new)

    should 'render form for account and user' do
      assert_select 'form[action$=?', accounts_path do
        assert_select 'input[name=?', 'account[subdomain]'
        assert_select 'input[name=?', 'user[email]'
        assert_select 'input[name=?', 'user[password]'
      end
    end
  end

  context 'on POST to #create with good values' do
    setup do
      post :create,
           account: { subdomain: 'foo' },
           user: { email: 'foo@bar.com', password: 'pass' }
    end

    should set_the_flash.to(/created/i)
    should_change 'User.count', by: 1
    should_change 'Account.count', by: 1
    should 'assign the user to the account' do
      assert_equal assigns(:account).id, assigns(:user.account_id)
    end
  end

  context 'on POST to #create with bad account values' do
    setup do
      post :create,
           account: {},
           user: { email: 'foo@bar.com', password: 'pass' }
    end

    should_not_change 'User.count'
    should_not_change 'Account.count'
    should assign_to(:account)
    should assign_to(:user)
    should render_template(:new)
  end

  context 'on POST to #create with bad user values' do
    setup do
      post :create,
           account: { subdomain: 'foo' },
           user: {}
    end

    should_not_change 'User.count'
    should_not_change 'Account.count'
    should assign_to(:account)
    should assign_to(:user)
    should render_template(:new)
  end
end
