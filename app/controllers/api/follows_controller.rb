module Api
  class FollowsController < ApiController
    def create
      @follow = current_blog.follows.new({target_id: params[:blog_id]})
      if @follow.save!
        render json: @follow
      else
        render json: @follow.errors.full_messages, status: :unprocessable_entity
      end
    end

    def destroy
      @follow = current_blog.follows.find_by_target_id(params[:id])
      if @follow.destroy!
        render json: {}
      else
        render json: @follow.errors.full_messages, status: :unprocessable_entity
      end
    end
  end
end
