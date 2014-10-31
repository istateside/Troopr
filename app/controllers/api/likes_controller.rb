module Api
  class LikesController < ApiController
    before_action :check_log_in
    def create
      post = Post.find(params[:post_id])
      @like = current_blog.likes.new({post: post, original_post_id: post.original_post_id})
      if @like.save
        Note.create!({original_post_id: post.original_post_id, notable_id: like.id, notable_type: "Like"})
        render json: @like
      else
        render json: @like.errors.full_messages, status: :unprocessable_entity
      end
    end
  
    def destroy
      @like = current_blog.likes.find(params[:id])
      @like.try(:destroy)
      render json: {}
    end
  end
end