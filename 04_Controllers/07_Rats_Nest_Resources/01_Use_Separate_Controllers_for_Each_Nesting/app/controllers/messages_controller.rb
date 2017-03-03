class MessagesController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @messages = @user.messages
    else
      @messages = Message.all
    end
  end
end

# refactoring

class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end
end
