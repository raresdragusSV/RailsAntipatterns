class UsersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @memberships = @user.memberships.where(active: true).limit(5)
                        .order('last_active_on DESC')
  end
end

# Refactoring

class UsersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @recent_active_memberships = @user.find_recent_active_memberships
  end
end
