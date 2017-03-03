class PasswordsController < ApplicationController
  def create
    user = User.find(params[:id])
    user.generate_password_reset_access_key
    user.password_confirmation = user.password
    user.email_confirmation = user.email
    user.save!
    flash[:notice] = user.first_name + ' ' + user.last_name + "'s password has been reset."
  end
end
