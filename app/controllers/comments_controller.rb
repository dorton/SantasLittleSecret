class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]


  def new
    @famorg = Famorg.find(params[:famorg_id])
    @comment = @famorg.comments.new
  end

  def edit
  end

  def create
    @famorg = Famorg.find(params[:famorg_id])
    @comment = @famorg.comments.new(comment_params)
    @comment.user = current_user
    @comment.save!

    respond_to do |format|
      format.html { redirect_to @famorg }
      format.json { render json: @famorg }
      format.js #render comments/create.js.erb
    end

  end

  def update
    @comment.update
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @famorg }
      format.json { render json: @famorg }
      format.js #render comments/destroy.js.erb
    end
  end

  private
      def set_comment
        @famorg = Famorg.find(params[:famorg_id])
        @comment = @famorg.comments.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body, famorg_ids: [])
      end
end
