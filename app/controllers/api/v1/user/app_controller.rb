module Api
  module V1
    module User
      class AppController < Api::AppController
        before_action :set_current_user_from_header

        def set_current_user_from_header
          auth_header = request.headers["auth-token"]
          if auth_header.present?
            jwt = auth_header.split(" ").last rescue nil
            result = JWT.decode(jwt, Rails.application.credentials.secret_key_base, true, { algorithm: "HS256" })
            payload = result.first rescue nil
            raise MYError.new(payload.to_json) unless payload
            @current_user = ::User.find_by(auth_token: payload["auth_token"]) rescue nil
          end
        end

        def current_user(auth = true)
          raise MYAuthenticationError.new("Not logged in or invalid auth token") if auth && @current_user.blank?
          @current_user
        end

      end
    end
  end
end

