class AuthController < ApplicationController
  skip_before_action :authorize_request, only: :login

  def login
    email = params[:email] || params.dig(:user, :email)
    password = params[:password] || params.dig(:user, :password)

    user = User.find_by(email: email)

    if user&.authenticate(password)
      token = JsonWebToken.encode(user_id: user.id)
      render json: {
        token: token,
        role: user.role
      }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end