class GroupsController < ApplicationController
  before_action :set_groups, only: [:show, :edit, :update, :destroy]


  def index

  end

  def show

  end





  def new
    @group = Famorg.new
  end

  def edit
  end

  def update
    #code
  end

  def create

  end

  def destroy
    @group.destroy
  end

  def group_invite
    @famorg = Famorg.find(params[:famorg_id])
    if params[:emails].present?
      emails = params[:emails].split(",").to_a
      emails.each do |email|
        if User.exists?(email: email)
          User.find_by(email: email).famorgs << @famorg, notice: "You have been invited into a new group."
        else
          user = User.new
          user.email = email.gsub("/\n\s+/", "")
          user.famorgs << @famorg
          user.invite!
      end
      redirect_to root_path, notice: "#{emails.count} #{'user'.pluralize(emails.count)} invited."
    end
  end

  private
      def set_groups
        @group = Famorg.find(params[:id])
      end

      def groups_params
        params.require(:famorg).permit(:name)
      end

end
