class GamesController < ApplicationController
  def index
    @games = game.paginate page: params[:page]
  end
end
