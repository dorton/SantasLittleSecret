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
      @user_famorg = UserFamorg.find_by(famorg_id: @famorg.id, user_id: current_user.id)
      @recipient = User.find(@user_famorg.santa_id) if @user_famorg.santa_id
      @comments = @famorg.comments
      @users_invitation_accepted = @famorg.users.invitation_accepted
      @users_invitation_not_accepted = @famorg.users.invitation_not_accepted
      @famorg_admin = UserFamorg.where(user_id: current_user.id).where(famorg_id: @famorg.id).first
      @whoisadmin = User.joins(:user_famorgs).where('user_famorgs.famorg_id = ?', @famorg.id).where('user_famorgs.admin = ?', true).first
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
      emails = params[:emails].split(",").map {|a| a.b.strip}
      exists = []
      newbies = []
      emails.each do |email|
        if User.exists?(email: email)
          User.find_by(email: email).famorgs << @famorg unless User.find_by(email: email).famorgs.include?(@famorg)
        else
          user = User.new
          user.email = email
          user.invite!
          user.famorgs << @famorg
          user.seasons << Season.where('seasons.year <= ?', Date.today.end_of_year).first
        end
      end
      redirect_to root_path, notice: "#{emails.count} #{'user'.pluralize(emails.count)} invited."
    end
  end

  def assign
    @famorg = Famorg.find(params[:famorg_id])
    @users = @famorg.users
    @season = Season.where('seasons.year <= ?', Date.today.end_of_year).first
    @group_season = SeasonFamorg.where(season_id: @season.id).where(famorg_id: @famorg.id)
    if @famorg.santas_assigned?
      redirect_to root_path, notice: 'Assignments Have Been Made.'
    else
      Gift.new.assign(@famorg.id, @season.id)
      @famorg.update_attributes(santas_assigned: true)
      @famorg.users.each do |user|
        UserMailer.assigned_notification(@famorg, user).deliver_later
      end

      redirect_to famorg_path(@famorg), notice: 'Assignments Have Been Made. WooHoo!'
    end
  end

  def accepted_invite
  end

  def remove_user
    @famorg = Famorg.find(params[:famorg_id])
    @user = User.find(params[:user_id])
    @famorg.users.delete(@user.id)
    redirect_to root_path
  end

  def update
    if @famorg.update(famorg_params)
      redirect_to famorg_path(@famorg), notice: 'Group was successfully updated.'
    else
       render :edit, notice: 'Something Happened.'
    end
  end


private
    def set_famorg
      @famorg = Famorg.find(params[:id])
    end

    def famorg_params
      params.require(:famorg).permit(:name, :cost, :date, :santas_assigned, comment_ids: [])
    end
end
