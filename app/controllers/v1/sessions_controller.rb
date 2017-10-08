module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user!

    def login
      user = User.find_by(email: params[:email])

      if user && user.valid_password?(params[:password])
        render json: user.as_json(only: [:email, :authentication_token])
      else
        head(:unauthorized)
      end  
    end

    def logout
      user = User.find_by(email: params[:email])
    end
  end
end