class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
    @games = Game.page params[:page]
    authorize! :index, Game
  end
end
