class ReviewsController < ApplicationController
	


	def index
		@reviews = current_user.reviews
	end

	def show 
		@review = Review.find(params[:id])
	end	



	def create
		@review = Review.new(review_params)		
		@review.user_id = current_user.id
		if @review.save
			redirect_to room_path(@review.room)
		else
			render action: "edit"
		end
	end


	def edit
		@review = Review.find(params[:id])
	end

	def update
		@review = Review.find(params[:id])
		if @review.update_attributes (review_params)
			redirect_to review_path(@review.id)
		else
			render action: "edit"
		end
	end


	def destroy
		@review = Review.find(params[:id])
		if @review.destroy
		redirect_to product_path(@review.product_id)
		end

	end


private

	def review_params

		params[:review].permit(:review,:cleanliness_rating,:safety_rating,:facility_rating,:locality_rating,:room_id)

	end



end
