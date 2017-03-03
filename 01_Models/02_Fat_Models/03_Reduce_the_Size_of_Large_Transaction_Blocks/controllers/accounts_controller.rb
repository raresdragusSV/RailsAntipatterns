class AccountsController < ApplicationController
  def create
    @account = Account.create_account!(params[:account], params[:user])
    redirect_to @account,
                notice: 'Your account was successfully created.'
  rescue
    render action: :new
  end
end

# refactoring
class AccountsController < ApplicationController
  def create
    @account = Account.new params[:account]
    if @account.save
      flash[:notice] = 'Your account was successfully created.'
      redirect_to account_url(@account)
    else
      render action: :new
    end
  end
end
