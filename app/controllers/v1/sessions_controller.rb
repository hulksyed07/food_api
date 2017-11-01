module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user!, only:[:login, :sign_up]
    # before_action :serialize_json_data, only: [:sign_up]

    def login
      user = User.find_by(email: params[:email])

      if user && user.valid_password?(params[:password])
        render json: {authentication_token: user.authentication_token, user: user.as_json(only: [:email, :first_name, :last_name])}
      else
        head(:unauthorized)
      end  
    end

    def sign_up
      user = User.create(user_params)
      if user.errors.blank?
        render json: {authentication_token: user.authentication_token, user: user.as_json(only: [:email, :first_name, :last_name])}
      else
        render json: user.errors.messages.as_json, status: 422
      end
    end

    def logout
      current_user.update(authentication_token: nil)
      render plain: 'Logout Successful'
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