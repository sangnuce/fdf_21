class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email:params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        if user.admin?
          redirect_to admin_users_path
        else
          redirect_to root_path
        end
      else
        flash[:warning] = t "flash.account_not_active"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "flash.invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
