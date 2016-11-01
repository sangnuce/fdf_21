class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "flash.activated"
    else
      flash[:danger] =  t "flash.invalid_activation_link"
    end
    redirect_to root_url
  end
end
