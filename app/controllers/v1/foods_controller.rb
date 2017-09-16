module V1
	class FoodsController < ApplicationController
		
		def index
			foods = Food.all
			render json: { status: 'SUCCESS', message: 'Loaded Foods', data: foods }, status: :ok
		end

		# def create

		# end

		# def update

		# end

		# def destroy

		# end

		private

		def food_params
			params.require(:food).permit(:name,:price)
		end
	end
end