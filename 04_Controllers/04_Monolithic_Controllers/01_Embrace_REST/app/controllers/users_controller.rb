class UsersController < ApplicationController
  def index
    per_page = Variable::default_pagination_value
    user_order = 'username'
    if not params[:user_sort_field].nil?
      user_order = params[:user_sort_field]
      if !session[:user_sort_field].nil? && user_order == session[:user_sort_field]
        user_order += ' DESC'
      end
      session[:user_sort_field] = user_order
    end

    @user_pages, @users = paginate(
      :users,
      order: user_order,
      conditions: ['item_status_id <> ?', ItemStatus.find_delete.id],
      per_page: per_page
    )
  end

  def destroy
    user = User.find(params[:id])
    user.item_status = ItemStatus.find_deleted
    user.password_confirmation = user.password
    user.email_confirmation = user.email
    user.save!
    flash[:notice] = user.first_name + ' ' + user.last_name + ' has been deleted.'
  end

  def show
    @user = User.find(params[:id])
    render template: show_user
  end
end
