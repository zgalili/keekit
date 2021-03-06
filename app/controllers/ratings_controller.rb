class RatingsController < ApplicationController
  def create
    @advertisement = Advertisement.find(params[:advertisement_id])
    
    rating = params[:rating]
    rating["user_id"] = current_user.id
    @ratings = @advertisement.ratings.create(rating)

    # update the ad's rating and rating_count to reflect the newly added rating
    ratings_sum = @advertisement.rating * @advertisement.ratings_count
    @advertisement.ratings_count += 1
    ratings_sum += @ratings.value
    @advertisement.rating = ratings_sum / @advertisement.ratings_count
    @advertisement.save

    # for coletivo recommendations
    current_user.rate!(@advertisement, @ratings.value)

    render json: { rating:@advertisement.rating.round(2), ad_id:@advertisement.id, your_rating:@ratings.value }
  end
end
