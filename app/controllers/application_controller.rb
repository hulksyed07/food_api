class ApplicationController < ActionController::API
	before_action :allow_cross_domain_interaction
	before_action :authenticate_user!

	protected

  def current_user
    token = request.headers['HTTP_ACCESS_TOKEN']
    User.find_by(authentication_token: token)
  end

	private
	
	def allow_cross_domain_interaction
		headers['Access-Control-Allow-Origin'] = 'http://localhost:5000'
		headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
		headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Access-Token, HTTP_ACCESS_TOKEN'
		# headers['Access-Control-Expose-Headers'] = 'HTTP_ACCESS_TOKEN'
		headers['Access-Control-Expose-Headers'] = 'Origin, Content-Type, Access-Token, HTTP_ACCESS_TOKEN'
		headers['Access-Control-Max-Age'] = "1728000"
	end

  def authenticate_user!
    token = request.headers['HTTP_ACCESS_TOKEN']
    unless token.present? && User.find_by(authentication_token: token).present?
      head(:unauthorized)
    end
  end
end
