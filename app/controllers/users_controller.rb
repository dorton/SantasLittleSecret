class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def show
    if current_user.santa.present?
      @user = User.find(params[:id])
    else
      @user = User.find(params[:id])
    end
    @comments = Comment.where("comments.writer = ?", current_user.id.to_s || current_user.santa)
  end

  def new
    unless current_user.admin
      redirect_to user_path(current_user), notice: "No Can Do, Mate."
    else
      @user = User.new
    end
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user), notice: "No Can Do, Mate."
    end
  end

  def create
    @user = User.new(user_params)
      if @user.save
         redirect_to @user, notice: 'User was successfully created.'
      else
        render :new
      end
  end

  def update

      if @user.update(user_params)
        redirect_to root_path, notice: 'User was successfully updated.'
      else
         render :edit
      end
  end


  def destroy
    @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :want, :profile_image, :remote_profile_image_url)
    end
end
