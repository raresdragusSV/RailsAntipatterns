class SignupsController < ApplicationController
  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(params[:signup])

    if @signup.save
      flash[:notice] = 'Thank you fot sign up!'
      redirect_to root_url
    else
      render action: 'new'
    end
  end
end
