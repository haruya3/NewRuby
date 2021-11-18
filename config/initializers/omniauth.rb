Rails.application.config.middleware.use OmniAuth::Builder do
  require 'omniauth/strategies/line'
  provider :line, ENV['LINE_APP_ID'], ENV['LINE_APP_SECRET']
end