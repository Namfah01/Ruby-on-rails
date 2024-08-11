class Api::V1::User::SessionsController < Api::V1::User::AppController
  skip_before_action :set_current_user_from_header, only: [:sign_in]
  def sign_in
    user = User.find_by_email(params[:user][:email])
    raise MYError.new("Invalid email") if user.blank?
    if user.valid_password?(params[:user][:password]) # valid_password เป็น function ของ divise
      render json: { success: true, user: user.as_json_with_jwt }
    else
      raise MYAuthenticationError.new("Invalid email or password")
    end
  end

  def sign_out
    current_user.generate_auth_token
    current_user.save
    render json: { success: true}
  end

  def me
    render json: {success: true, user: current_user.as_profile_json}
  end
end
