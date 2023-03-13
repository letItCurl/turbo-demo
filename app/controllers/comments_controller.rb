class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments
  end

  def show
    @comment = @post.comments.find(params[:id])
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update
    @comment = @post.comments.find(params[:id])
    @comment.update(post_params)
    respond_to do |format|
      if @comment.valid?
        format.html { redirect_to @post }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@comment, partial: "comments/form", locals: {post: @post, comment: @comment}) }
      end
    end
  end

  def create
    @comment = @post.comments.new(post_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@comment, partial: "comments/form", locals: {post: @post, comment: @comment}) }
      end
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def post_params
    params.require(:comment).permit(:content)
  end
end
