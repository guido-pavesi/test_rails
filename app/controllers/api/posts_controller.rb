class Api::PostsController < ApplicationController
  def index
    @posts = Post.includes(:tags)

    render json: serialize_posts(@posts)
  end

  def serialize_posts(posts)
    @posts.map do |post|
      {
        title: post.title,
        id: post.id,
        tags: post.tags.map { |tag| { name: tag.name } }
      }
    end
  end

  def filter
    term = params[:term]
    @posts = Post.includes(:tags).where('lower(title) LIKE ? OR lower(tags.name) LIKE ?', "%" + term.downcase + "%", "%" + term.downcase + "%").references(:tags)
    render json: serialize_posts(@posts)
  end
end
