class HomeController < ApplicationController
  def index
    @famorg = Famorg.joins(:users).where('users.id = ?', current_user.id).first
    @season = Season.where('seasons.year <= ?', Date.today.end_of_year).first
    @group_season = SeasonFamorg.where(season_id: @season.id).where(famorg_id: @famorg.id)
    @recipient = User.find(current_user.santa) if current_user.santa.present?
    @comments = Comment.where("comments.reader = ?", current_user.id.to_s || current_user.santa)
  end

  def assign
    @famorg = Famorg.joins(:users).where('users.id = ?', current_user.id).first
    @season = Season.where('seasons.year <= ?', Date.today.end_of_year).first
    @group_season = SeasonFamorg.where(season_id: @season.id).
                                 where(famorg_id: @famorg.id)
    if @group_season.first.santas_assigned?
      redirect_to root_path, notice: 'Assignments Have Been Made. You Have Who You Have.'
    else
      Gift.new.assign(@famorg.id, @season.id)
      @group_season.first.update_attributes(santas_assigned: true)
      redirect_to root_path, notice: 'Assignments Have Been Made. You Have Who You Have.'
    end
  end

end
