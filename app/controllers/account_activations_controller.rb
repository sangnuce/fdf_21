class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = t "flash.activated"
    else
      flash[:danger] =  t "flash.invalid_activation_link"
    end
    redirect_to root_url
  end
end
