Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, CONFIG['GOOGLE_KEY'], CONFIG['GOOGLE_SECRET'], { hd: 'code-for-kids.com', scope: 'userinfo.email,userinfo.profile' }
end
