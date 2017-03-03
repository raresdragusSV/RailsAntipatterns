class SessionsController < ApplicationController
  def new
    # Just render the sessions/new.html.erb template
  end

  def create
    if session[:user_id] = User.authenticate(
      params[:user][:login],
      params[:user][:password]
    )
      flash[:message] = 'Login successful'
      redirect_to root_url
    else
      flash.now[:warning] = 'Login unsuccessful'
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = 'Logged out'
    redirect_to login_url
  end
end
