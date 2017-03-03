class AdminController < ApplicationController
  def users
    per_page = Variable::default_pagination_value
    @users = User.find(:all)
    # First check to see if there
    # was an operation performed
    if not params[:operation].nil?
      if params[:operation] == 'reset_password'
        user = User.find(params[:id])
        user.generate_password_reset_access_key
        user.password_confirmation = user.password
        user.email_confirmation = user.email
        user.save!
        flash[:notice] = user.first_name + ' ' + user.last_name + "'s password has been reset."
      end

      if params[:operation] == 'delete_user'
        user = User.find(params[:id])
        user.item_status = ItemStatus.find_deleted
        user.password_confirmation = user.password
        user.email_confirmation = user.email
        user.save!
        flash[:notice] = user.first_name + ' ' + user.last_name + ' has been deleted.'
      end

      if params[:operation] == 'activate_user'
        user = User.find(params[:id])
        user.item_status = ItemStatus.find_active
        user.password_confirmation = user.password
        user.email_confirmation = user.email
        user.save!
        flash[:notice] = user.first_name + ' ' + user.last_name + ' has been activated.'
      end

      if params[:operation] == 'show_user'
        @user = User.find(params[:id])
        render template: show_user
        return true
      end

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
        conditions: ['item_status_id <> ?', ItemStatus.find_deleted.id],
        per_page: per_page
      )
    end
  end
end
