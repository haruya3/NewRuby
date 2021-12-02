Rails.application.config.middleware.use OmniAuth::Builder do
  require 'omniauth/strategies/line'
  provider :line, ENV['LINE_APP_ID'], ENV['LINE_APP_SECRET'], {strategy_class: OmniAuth::Strategies::Line}
  provider :facebook,  ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], scope: 'public_profile email'
end
