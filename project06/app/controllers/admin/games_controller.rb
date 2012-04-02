class Admin::GamesController < Admin::AdminController
  authorize_resource
  controls :games, as: :admin, redirect_url: :admin_games_url
end
