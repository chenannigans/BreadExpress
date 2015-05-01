class UsersController < ApplicationController

  include BreadExpressHelpers::Cart

  before_action :set_user, only: [:edit, :update]

  skip_before_action :check_login, only: [:new, :create]

  def new
   @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
         session[:user_id] = @user.id
      redirect_to(home_path, :notice => 'User was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to(@user, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

 

  private

  def set_user
      @user = User.find(params[:id])
    end
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :role, :active)
  end


end
