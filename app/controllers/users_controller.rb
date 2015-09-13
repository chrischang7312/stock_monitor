class UsersController < ApplicationController  
  before_filter :save_login_state, :only => [:new, :create]

  def new
    @user = User.new 
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render "session/home"
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation)
  end
end