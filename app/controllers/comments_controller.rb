class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]



  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.users << current_user
    @comment.users << User.find(current_user.santa)
    @comment.writer = current_user.id
    @comment.reader = current_user.santa

    if @comment.save
      redirect_to user_path(current_user.santa), notice: "Comment Updated"
    else
      redirect_to user_path(current_user.santa), notice: "Comment Not Saved"
    end
  end

  def update
    if @comment.update
      redirect_to user_path(current_user.santa), notice: "Comment Updated"
    else
      redirect_to user_path(current_user.santa), notice: "Comment Not Saved"
    end
  end

  def destroy
    @comment.destroy
    redirect_to user_path(current_user.santa)
  end

  private
      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
end
