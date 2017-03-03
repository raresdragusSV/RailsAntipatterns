class UsersController < ApplicationController
  def index
    @users = User.order('last_name')
  end
end

# Refactoring

class UsersController < ApplicationController
  def index
    @users = User.ordered
  end
end
