class SessionsController < ApplicationController
  
  # before_action :ensure_logged_in, only: [:create]
  
  def create
    @user = User.find_by_credentials(
      params[:user][:user_name], 
      params[:user][:password]
    )
    
    if @user.nil?
      render :new
    else
      log_in!(@user)
      redirect_to cats_url
    end
  end
  
  def new
    render :new
  end
  
  def destroy
    log_out!
    redirect_to new_session_url
  end
  
  def ensure_logged_in
    redirect_to cats_url if @user.nil?
  end
  
end
