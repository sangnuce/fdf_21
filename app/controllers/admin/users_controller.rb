class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, except: [:index, :new, :create]
  before_action :valid_user, only: [:destroy]

  def index
    @users = if user_name = params[:name]
      User.name_like user_name
    else
      User.activated
    end.paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.activate
      flash[:info] = t "flash.add_user_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.update_user_success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "flash.delete_user"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :phone, :password,
      :password_confirmation, :admin
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "flash.user_not_found"
      redirect_to root_path
    end
  end

  def valid_user
    if @user.current_user? @current_user
      flash[:danger] = t "flash.cant_delete"
      redirect_to admin_users_path
    end
  end
end
