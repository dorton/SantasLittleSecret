class FamorgsController < ApplicationController
  before_action :set_famorg, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    if @user.famorgs.empty?
      redirect_to new_famorg_path
    else
      if @user.famorgs.count > 1
        @famorgs = @user.famorgs.all
      else
        redirect_to famorg_path(@user.famorgs.first)
      end
    end
  end

  def show
    if current_user.famorgs.present?
      @user = current_user
      @season = Season.where('seasons.year <= ?', Date.today.end_of_year).first
      @group_season = SeasonFamorg.where(season_id: @season.id).where(famorg_id: @famorg.id)
      @recipient = User.find(current_user.santa) if current_user.santa.present?
      @comments = Comment.where("comments.reader = ?", current_user.id.to_s || current_user.santa)
      @users_invitation_accepted = @famorg.users.invitation_accepted
      @users_invitation_not_accepted = @famorg.users.invitation_not_accepted
      @famorg_admin = UserFamorg.where(user_id: current_user.id).where(famorg_id: @famorg.id).first
    end
  end

  def new
    @famorg = Famorg.new
  end

  def edit
  end

  def create
    famorg = Famorg.new(famorg_params)
    if famorg.save
      famorg.users << current_user
      famorg.seasons << Season.where('seasons.year <= ?', Date.today.end_of_year).first
      famorg_admin = UserFamorg.where(user_id: current_user.id).where(famorg_id: famorg.id).first
      famorg_admin.update_attributes(admin: true)
      redirect_to group_invite_path(famorg)
    else
      render :new
    end
  end

  def destroy
    @famorg.destroy
  end

  def group_invite
    @famorg = Famorg.find(params[:famorg_id])
    if params[:emails].present?
      emails = params[:emails].split(",").to_a
      emails.each do |email|
        user = User.where(email: email).first_or_initialize
        user.email = email.gsub("/\n\s+/", "")
        user.invite!
        user.famorgs << @famorg
      end
      redirect_to root_path, notice: "#{emails.count} #{'user'.pluralize(emails.count)} invited."
    end
  end

  def assign
    @famorg = Famorg.find(params[:famorg_id])
    @season = Season.where('seasons.year <= ?', Date.today.end_of_year).first
    @group_season = SeasonFamorg.where(season_id: @season.id).where(famorg_id: @famorg.id)
    if @group_season.first.santas_assigned?
      redirect_to root_path, notice: 'Assignments Have Been Made. You Have Who You Have.'
    else
      Gift.new.assign(@famorg.id, @season.id)
      @group_season.first.update_attributes(santas_assigned: true)
      redirect_to root_path, notice: 'Assignments Have Been Made. You Have Who You Have.'
    end
  end

  def accepted_invite
  end


private
    def set_famorg
      @famorg = Famorg.find(params[:id])
    end

    def famorg_params
      params.require(:famorg).permit(:name)
    end
end
