# lib/omniauth/strategies/line.rb

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Line < OmniAuth::Strategies::OAuth2
      # IDトークンからemailを取得するために'email'が必要
      # IDトークンからプロフィール画像を取得するのに'profile'が必要
      option :scope, 'openid email profile'

      option :client_options, {
        site:          'https://api.line.me',
        authorize_url: 'https://access.line.me/oauth2/v2.1/authorize',
        token_url:     'https://api.line.me/oauth2/v2.1/token'
      }

      uid do
        raw_info[:userId]
      end

      info do
        {
          user_id:     raw_info[:sub],
          name:        raw_info[:name],
          email:       raw_info[:email],
          picture_url: raw_info[:picture]
        }
      end

      def raw_info
        @raw_info ||= verify_id_token
      end

      private

      # nonceをリクエストパラメータに追加するためoverride
      def authorize_params
        super.tap do |params|
          params[:nonce] = SecureRandom.uuid
          session["omniauth.nonce"] = params[:nonce]
        end
      end

      def callback_url
        full_host + script_name + callback_path
      end

      ##omniauth-line, 
      def verify_id_token #a ||= はaが値があればなにもせず、偽ならば代入するというもの。よく、初期化で使われる。
        @id_token_payload ||= client.request(:post, 'https://api.line.me/oauth2/v2.1/verify',
          {
            body: {
              id_token:  access_token[:id_token],
              client_id: options.client_id,
              nonce:     session.delete("omniauth.nonce")
            }
          }
        ).parsed
        #parseでリクエスト内容を読み込んでいるというのが俺の最大の理解。
        @id_token_payload
      end
    end
  end
end