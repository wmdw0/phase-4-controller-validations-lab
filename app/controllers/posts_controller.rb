class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
      post = find_post
      # update! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code
      post.update!(post_params)
      render json: post
  end

  private

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def find_post
    Post.find(params[:id])
  end

  def post_params
    params.permit(:title, :category, :content)
  end

  def render_not_found_response
    render json: { error: "Post not found" }, status: :not_found
  end

end
