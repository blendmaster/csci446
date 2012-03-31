class GamesController < ApplicationController
  skip_authorization_check

  def index
    @games = Game.includes(:user).paginate page: params[:page]
  end
end
