class ActivationsController < ApplicationController
  def create
    user = User.find(params[:id])
    user.item_status = ItemStatus.find_active
    user.password_confirmation = user.password
    user.email_confirmation = user.email
    user.save!
    flash[:notice] = user.first_name + ' ' + user.last_name + ' has been activated.'
  end
end
