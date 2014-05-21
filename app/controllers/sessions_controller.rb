class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to timetrackers_path, :notice => "You have successfully signed in."
  end

  def destroy
    session[:user_id] = nil
    current_user = nil
    redirect_to root_url, :notice => "You have been signed out."
  end

end
