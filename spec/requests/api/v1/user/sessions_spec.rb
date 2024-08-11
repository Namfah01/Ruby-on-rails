class Api::V1::User::SessionsController < Api::V1::User::AppController
  skip_before_action :set_current_user_from_header, only: [:sign_in]

  def sign_in
    user = User.find_by_email(params[:user][:email])
    raise MYError.new("Invalid email") if user.blank?
    
    if user.valid_password?(params[:user][:password])
      auth_jwt = generate_jwt_for_user(user) # Method to generate JWT
      render json: {
        success: true,
        auth_jwt: auth_jwt,
        user: {
          email: user.email,
          first_name: user.first_name,
          last_name: user.last_name
        }
      }
    else
      raise MYAuthenticationError.new("Invalid email or password")
    end
  end

  def sign_out
    current_user.generate_auth_token
    current_user.save
    render json: { success: true }
  end

  def me
    render json: { success: true, user: current_user.as_profile_json }
  end

  private

  def generate_jwt_for_user(user)
    # Implement JWT generation logic
    JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base, 'HS256')
  end
end

