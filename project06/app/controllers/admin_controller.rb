class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    unless current_user.admin?
      redirect_to members_path, alert: "You don't have permission for that!"
    end
  end

  def index
    @games = Game.page params[:page]
  end
end
