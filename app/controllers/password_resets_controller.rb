class PasswordResetsController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "flash.send_email_reset_success"
      redirect_to root_url
    else
      flash.now[:danger] = t "flash.wrong_email"
      render "new"
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("password_resets/cant_empty")
      render "edit"
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attributes reset_digest: nil
      flash[:success] = t "flash.reset_success"
      redirect_to root_path
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def find_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "flash.password_expired"
      redirect_to new_password_reset_url
    end
  end
end
