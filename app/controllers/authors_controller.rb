class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    author = Author.find(params[:id])

    render json: author
  end

  def create
    author = Author.create!(author_params)
    render json: author, status: :created
    # author = Author.create(author_params)

    # render json: author, status: :created
  end

  private
  
  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def author_params
    params.permit(:name, :email)
  end

  def render_not_found_response
    render json: { error: "Post not found" }, status: :not_found
  end
  
end
