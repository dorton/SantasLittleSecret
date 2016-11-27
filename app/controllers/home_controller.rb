class HomeController < ApplicationController
  def index
    @season = Season.where('seasons.year <= ?', Date.today.end_of_year).first
  end
end
