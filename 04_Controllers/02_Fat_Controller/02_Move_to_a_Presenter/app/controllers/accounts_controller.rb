class AccountsController < ApplicationController
  def new
    @account = Account.new
    @user = User.new
  end

  def create
    @account = Account.new(params[:account])
    @user = User.new(params[:user])
    @user.account = @account

    if @account.save & @user.save
      flash[:notice] = 'Account was successfully created.'
      redirect_to @account
    else
      render action: 'new'
    end
  end
end

# resolving the bug
class AccountsController < ApplicationController
  def new
    @account = Account.new
    @user = User.new
  end

  def create
    @account = Account.new(params[:account])
    @user = User.new(params[:user])
    @user.account = @account

    ActiveRecord::Base.transaction do
      @account.save!
      @user.save!
    end

    flash[:notice] = 'Account was successfully created.'
    redirect_to @account
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
      render action: 'new'
    end
  end
end
