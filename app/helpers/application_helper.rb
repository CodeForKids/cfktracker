module ApplicationHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def gravatar(email,gravatar_options={})
    grav_url = 'https://www.gravatar.com/avatar.php?'
    grav_url << { :gravatar_id => Digest::MD5.new.update(email), :rating => gravatar_options[:rating], :size => gravatar_options[:size], :default => gravatar_options[:default] }.to_query
    grav_url
  end

  def can_delete_user?
    @current_user.email == "julian@code-for-kids.com" || @current_user.email == "lucas@code-for-kids.com"
  end

end
