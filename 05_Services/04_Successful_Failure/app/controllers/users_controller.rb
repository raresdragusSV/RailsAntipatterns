class UsersController < ApplicationController
  before_filter :ensure_user_is_admin

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = 'User successfully created.'
      redirect_to users_path
    else
      render action: :new
    end
  end

  protected

  def ensure_user_is_admin
    if !current_user.admin?
      flash.now[:failure] = 'You do not have permission to perform this action'
      render template: 'sessions/new', status: :unauthorized
    end
  end
end
