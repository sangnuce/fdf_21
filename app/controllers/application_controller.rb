class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "flash.must_logged_in"
      redirect_to login_url
    end
  end

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end
end
