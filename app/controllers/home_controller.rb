class HomeController < ApplicationController
  def index
    @famorg = Famorg.joins(:users).where('users.id = ?', current_user.id).first
    @season = Season.where('seasons.year <= ?', Date.today.end_of_year).first
  end
  def assign
    @famorg = Famorg.joins(:users).where('users.id = ?', current_user.id).first
    @season = Season.where('seasons.year <= ?', Date.today.end_of_year).first
    Gift.new.assign(@famorg.id, @season.id)
  end
end
