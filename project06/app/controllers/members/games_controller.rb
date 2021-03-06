class Members::GamesController < Members::MembersController
  before_filter only: [:show, :edit, :destroy] do
    @game = current_user.games.find(params[:id])
    authorize! :manage, @game
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to members_games_path, alert: "That game doesn't exist!"
  end
  
  # can't use controls because it's a nested resource
  def index
    @games = current_user.games.page params[:page]
    @rated = 100 * (current_user.games.count(:rating).to_f / @games.total_entries) 
    authorize! :index, Game # can't pass in @games, apparently
  end
  
  def new
    @game = current_user.games.build
    authorize! :new, @game
  end
  
  def create
    @game = current_user.games.build params[:game]
    authorize! :create, @game
    if @game.save
      redirect_to members_games_path, notice: "added #{@game}!"
    else
      render :edit
    end
  end
  
  def show
  end
  
  def edit
  end

  def update
    @game = current_user.games.find params[:id]
    authorize! :update, @game
    if @game.update_attributes params[:game]
      redirect_to members_games_path, notice: "updated #{@game}!"
    else
      render :edit
    end
  end
  
  def destroy
    @game.destroy
    redirect_to members_path, notice: "deleted game"
  end
end
