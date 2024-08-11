class Api::V1::User::SessionsController < Api::V1::User::AppController
  skip_before_action :set_current_user_from_header, only: [:sign_in]

  def sign_in
    email = params[:email]
    password = params[:password]

    # Find user by email
    user = User.find_by(email: email)
    if user.blank?
      return render json: { success: false, error: "Invalid email" }, status: :unprocessable_entity
    end

    # Authenticate user
    if user.valid_password?(password)
      render json: { success: true, user: user.as_json_with_jwt }
    else
      render json: { success: false, error: "Invalid email or password" }, status: :unauthorized
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
end


