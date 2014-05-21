class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate, except: :root

  def root
    if current_user
      @users = User.all
    end
  end

  private

  def authenticate
    redirect_to root_url if current_user.nil?
  end

end
