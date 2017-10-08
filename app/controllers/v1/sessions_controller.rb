module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user!
    # before_action :serialize_json_data, only: [:sign_up]

    def login
      user = User.find_by(email: params[:email])

      if user && user.valid_password?(params[:password])
        render json: user.as_json(only: [:email, :authentication_token, :first_name, :last_name])
      else
        head(:unauthorized)
      end  
    end

    def sign_up
      user = User.create(user_params)
      if user.errors.blank?
        render json: user.as_json(only: [:email, :authentication_token, :first_name, :last_name])
      else
        render json: user.errors.messages.as_json
      end
    end

    def logout
      user = User.find_by(authentication_token: request.headers['HTTP_ACCESS_TOKEN'])
      if user && user.update(authentication_token: nil)
        render plain: 'Logout Successful'
      else
        head(:unauthorized)
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

    # def serialize_json_data
    #   params = ActiveModelSerializers::Deserialization.jsonapi_parse(ActionController::Parameters.new(params))
    # end
  end
end