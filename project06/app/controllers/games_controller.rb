class GamesController < ApplicationController
  def index
    @games = Game.includes(:user).paginate page: params[:page]
  end
end
