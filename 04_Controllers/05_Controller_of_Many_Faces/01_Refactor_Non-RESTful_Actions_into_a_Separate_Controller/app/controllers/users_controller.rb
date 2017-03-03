class UsersController < ApplicationController
  def login
    if request.post?
      if session[:user_id] =
        User.authenticate(params[:user][:login],
                          params[:user][:password])
        flash[:message] = 'Login successful'
        redirect_to root_url
      else
        flash[:warning] = 'Login unsuccessful'
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:message] = 'Logged out'
    redirect_to action: 'login'
  end

  # ... RESTful actions ...
end
