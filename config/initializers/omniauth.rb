OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
end


#OmniAuth.config.on_failure = Proc.new do |env|
#  "SessionsController".constantize.action(:omniauth_failure).call(env)
#end

