module V1
	class CategoriesController < ApplicationController

		def index
			categories = Category.all
			render json: { status: 'SUCCESS', message: 'Loaded Categories', data: categories }, status: :ok
		end

		def show
			category = Category.find(params[:id])
			foods =  category.foods
			render json: { status: 'SUCCESS', message: 'Loaded Category', data: foods}, status: :ok
		end

		# def create

		# end

		# def update

		# end

		# def destroy

		# end

		private

		def food_params
			params.require(:category).permit(:name)
		end
	end
end