class UsersController < ApplicationController
  def index
    @users = User.search(params[:search], params[:page])
  end
end

# using Sphinx
class UsersController < ApplicationController
  def index
    User.search(params[:search], page: params[:page], match_mode: :any)
  end
end

# using pattern matching
class UsersController < ApplicationController
  def index
    @users = User.search(
      params[:search], page: params[:page], match_mode: :any, start: true
    )
  end
end

# advanced functionality
class UsersController < ApplicationController
  def index
    @users = User.search(
      params[:search],
      with: {
        deleted: false,
        created_at: 1.week.ago..Time.now
      },
      order: :created_at
    )
  end
end
