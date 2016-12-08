class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]



  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @famorg = Famorg.find(params[:famorg_id])
    @comment = @famorg.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to famorg_path(@famorg), notice: "Comment Create"
    else
      redirect_to famorg_path(@famorg), notice: "Comment Not Saved"
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
        params.require(:comment).permit(:body, famorg_ids: [])
      end
end
