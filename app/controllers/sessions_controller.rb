class SessionsController < ApplicationController
  skip_before_action :authenticate
  
  def create
    user = User.find_or_create_from_omniauth(auth_params)
    if user
      log_in(user)
      redirect_to user_path(user)
    else
      redirect_to root_path, notice: "could not be authenticated with GitHub"
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private 

    def auth_params
      request.env["omniauth.auth"]
    end
end