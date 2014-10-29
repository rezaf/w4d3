class UsersController < ApplicationController
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  protected
  
  def user_params
    self.params.require(:user).permit(:user_name, :password)
  end
end
